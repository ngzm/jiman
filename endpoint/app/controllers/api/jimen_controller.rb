# frozen_string_literal: true

module Api
  #
  # jiman-api controller of the jimen
  #
  class JimenController < ApiController
    before_action :check_id, only: %i[show jump]
    before_action :check_category_id, only: :list
    before_action :parse_json, only: %i[create]

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
      @jimen = Jiman.includes(:categories)
                    .where(categories: { id: @category_id })
      raise RecordNotFound, 'No contents of jiman found' if @jimen.empty?

      render 'index', formats: :json, handlers: 'jbuilder'
    end

    def jump
      @jiman = Jiman.find_by_id(@id)
      raise RecordNotFound, 'Not found' if @jiman.nil?

      @jiman.increment_access
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    def create
      @jiman = Jiman.new
      jiman_data(jiman_params)

      @jiman.image_text(
        jiman_params[:file],
        jiman_params[:type],
        jiman_params[:imgdata]
      )
      @jiman.save!
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    private

    # Check parameter category_id
    def check_category_id
      @category_id = params[:category_id]
      return if @category_id =~ /^\d+$/

      raise BadRequest, "Invalid category id: #{@category_id}"
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def jiman_params
      params.require(:jiman).permit(:imgdata, :file, :type, :title, :description, :url, :point1, :point2, :point3, :point4, :point5, :point6)
    end

    def jiman_data(params)
      @jiman.title = params[:title]
      @jiman.description = params[:description]
      @jiman.url = params[:url]
      @jiman.point1 = params[:point1]
      @jiman.point2 = params[:point2].present? ? params[:point2] : nil
      @jiman.point3 = params[:point3].present? ? params[:point3] : nil
      @jiman.point4 = params[:point4].present? ? params[:point4] : nil
    end
  end
end
