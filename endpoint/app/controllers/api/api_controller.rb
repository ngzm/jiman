# frozen_string_literal: true

module Api
  # module for Errors
  # BusinessError base class
  class BusinessError < RuntimeError
    def http_status
      :internal_server_error
    end

    def error_level
      'warning'
    end
  end

  # Internal server error
  class ServerError < BusinessError
    def error_level
      'error'
    end
  end

  # Badrequest error
  class BadRequest < BusinessError
    def http_status
      :bad_request
    end
  end

  # Recored not found error
  class RecordNotFound < BusinessError
    def http_status
      :not_found
    end
  end

  #
  # jiman base controller
  #
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    include Authentication

    rescue_from StandardError, with: :handle_500_error
    rescue_from ActiveRecord::RecordInvalid, with: :handle_422_error
    rescue_from Auths::Error::AuthError, with: :handle_auth_error
    rescue_from RecordNotFound, with: :handle_404_error
    rescue_from BusinessError, with: :handle_business_error

    private

    def authenticated?
      # raise Auths::Error::Unauthorized, 'Faild to authenticate' \
      #   unless authenticate_token
      @authed_user = verify_auth_token(authenticate_tokens)
    end

    def authenticate_tokens
      access_token = nil
      authenticate_with_http_token do |token|
        access_token = token
      end
      provider = request.headers[:HTTP_X_AUTH_PROVIDER]
      identifier = request.headers[:HTTP_X_AUTH_USER_SUB]

      raise(Auths::Error::Forbidden, 'No authenticate tokens')  \
        unless access_token && provider && identifier

      { access_token: access_token, provider: provider, identifier: identifier }
    end

    # Standard Error handler
    def handle_500_error(err)
      logger.error("500 ERROR: #{err.message}")
      error_datas = []
      error_datas.push(level: 'fatal', message: err.message)
      render json: error_datas, status: 500
    end

    # Validate Error handler
    def handle_422_error(invalid)
      error_datas = []
      invalid.record.errors.full_messages.each do |msg|
        logger.warn("422 ERROR: #{msg}")
        error_datas.push(level: 'warning', message: msg)
      end
      render json: error_datas, status: 422
    end

    # NOT FOUND Error handler (It's OK to include BUSINESS ERROR)
    def handle_404_error(err)
      logger.error("404 ERROR: status: #{err.http_status}: #{err.message}")
      error_datas = []
      error_datas.push(level: err.error_level, message: err.message)
      render json: error_datas, status: 404
    end

    # Auth Error handler
    def handle_auth_error(err)
      logger.warn("AUTH ERROR: status: #{err.http_status}: #{err.message}")
      error_datas = []
      error_datas.push(level: err.error_level, message: err.message)
      render json: error_datas, status: err.http_status
    end

    # Business Error handler
    def handle_business_error(err)
      logger.error("BUSINESS ERROR: status: #{err.http_status}: #{err.message}")
      error_datas = []
      error_datas.push(level: err.error_level, message: err.message)
      render json: error_datas, status: err.http_status
    end
  end
end
