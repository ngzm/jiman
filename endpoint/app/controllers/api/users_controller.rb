# frozen_string_literal: true

module Api
  #
  # users-api controller
  #
  class UsersController < ApiController
    before_action :authenticated?
    before_action :check_id, only: %i[show]

    def index
      @users = User.all
      raise RecordNotFound, 'No records on jiman items' if @users.empty?

      render 'index', formats: :json, handlers: 'jbuilder'
    end

    def show
      @user = User.find(@id)
      raise RecordNotFound, 'Not found' if @user.nil?

      render 'show', formats: :json, handlers: 'jbuilder'
    end

    def authed
      raise RecordNotFound, 'Not found' if @authed_user.nil?

      @user = @authed_user
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    private

    # Check parameter id
    def check_id
      @id = params[:id]
      return if @id =~ /^\d+$/

      raise BadRequest, "Invalid user id: #{@id}"
    end
  end
end
