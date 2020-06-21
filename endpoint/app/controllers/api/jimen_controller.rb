# frozen_string_literal: true

module Api
  #
  # jiman-api controller of the jimen
  #
  class JimenController < ApiController
    before_action :authenticated?, only: %i[create update]
    before_action :check_id, only: %i[show jump update]
    before_action :parse_json, only: %i[create update]

    def index
      @jimen = Jiman.all
      raise RecordNotFound, 'No records on jiman items' if @jimen.empty?

      render 'index', formats: :json, handlers: 'jbuilder'
    end

    def show
      @jiman = Jiman.includes(:categories).find_by_id(@id)
      raise RecordNotFound, 'Not found' if @jiman.nil?

      @categories = @jiman.categories
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    def list
      check_category_id
      @jimen = Jiman.includes(:categories)
                    .where(categories: { id: @category_id })
      raise RecordNotFound, 'No contents of jiman found' if @jimen.empty?

      render 'index', formats: :json, handlers: 'jbuilder'
    end

    def ulist
      check_user_id
      @jimen = Jiman.where(user_id: @user_id)
      raise RecordNotFound, 'No contents of jiman found' if @jimen.empty?

      @user = User.find(@user_id)
      raise RecordNotFound, 'Not found' if @user.nil?

      render 'ulist', formats: :json, handlers: 'jbuilder'
    end

    def update
      @jiman = Jiman.find_by(id: @id, user_id: @authed_user.id)
      raise RecordNotFound, 'Not found' if @jiman.nil?

      Jiman.save_jiman(@jiman, @authed_user.id, jiman_params)
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    def create
      @jiman = Jiman.new
      Jiman.save_jiman(@jiman, @authed_user.id, jiman_params)
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    def jump
      @jiman = Jiman.find(@id)
      raise RecordNotFound, 'Not found' if @jiman.nil?

      @jiman.increment_access
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    private

    # Check parameter category_id
    def check_category_id
      @category_id = params[:category_id]
      return if @category_id =~ /^\d+$/

      raise BadRequest, "Invalid category id: #{@category_id}"
    end

    # Check parameter user_id
    def check_user_id
      @user_id = params[:user_id]
      return if @user_id =~ /^\d+$/

      raise BadRequest, "Invalid user id: #{@user_id}"
    end

    # Check parameter id
    def check_id
      @id = params[:id]
      return if @id =~ /^\d+$/

      raise BadRequest, "Invalid jiman id: #{@id}"
    end

    # Parse jiman json data to params
    def parse_json
      params[:jiman] = JSON.parse(request.body.read, symbolize_names: true)
    end

    # Strong parameters
    def jiman_params
      params.require(:jiman).permit(
        :title, :description, :url,
        :point1, :point2, :point3, :point4, :point5, :point6,
        imagedata: %i[name type base64data],
        categories: [:id, :name]
      )
    end
  end
end
