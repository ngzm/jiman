# frozen_string_literal: true

module Api
  #
  # jiman-api controller of the jimen
  #
  class JimenController < ApiController
    before_action :check_category_id, only: :list

    def index
      @jimen = Jiman.all
      raise RecordNotFound, 'No records on jiman items' if @jimen.empty?

      render 'index', formats: :json, handlers: 'jbuilder'
    end

    def list
      @jimen = Jiman.includes(:categories).where(categories: { id: @category_id})
      raise RecordNotFound, 'No contents of jiman found' if @jimen.empty?

      render 'index', formats: :json, handlers: 'jbuilder'
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

      raise BadRequest, "Invalid game id: #{@id}"
    end
  end
end
