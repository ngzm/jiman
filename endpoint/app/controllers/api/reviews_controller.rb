# frozen_string_literal: true

module Api
  #
  # reviews-api controller of the jimen
  #
  class ReviewsController < ApiController
    before_action :check_jiman_id
    before_action :parse_json, only: %i[save]
    before_action :authenticated?, only: %i[show save]

    def show
      @review = Review.find_by(jiman_id: @jiman_id, user_id: @user_id)
      raise RecordNotFound, 'Not found' if @review.nil?

      render 'show', formats: :json, handlers: 'jbuilder'
    end

    def list
      @reviews = Review.where(jiman_id: @jiman_id).order(updated_at: :desc)[0, 7]
      raise RecordNotFound, 'No contents of jiman found' if @reviews.empty?

      render 'index', formats: :json, handlers: 'jbuilder'
    end

    def save
      @review = Review.find_by(jiman_id: @jiman_id, user_id: @user_id)
      if @review.present?
        up = {}.merge(review_params)
        @review.update_review up
      else
        up = { jiman_id: @jiman_id, user_id: @user_id }.merge(review_params)
        @review = Review.new up
        @review.save_review
      end
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    private

    # Check parameter jiman_id
    def check_jiman_id
      @jiman_id = params[:jiman_id]
      return if @jiman_id =~ /^\d+$/

      raise BadRequest, "Invalid category id: #{@jiman_id}"
    end

    # Parse review json data to params
    def parse_json
      params[:review] = JSON.parse(request.body.read, symbolize_names: true)
    end

    # Strong parameters
    def review_params
      params.require(:review).permit(:comment, :star)
    end
  end
end
