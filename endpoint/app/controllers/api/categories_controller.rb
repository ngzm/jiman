# frozen_string_literal: true

module Api
  #
  # jiman-api controller of the categories
  #
  class CategoriesController < ApiController
    def index
      @categories = Category.all
      raise RecordNotFound, 'No records on categories' if @categories.empty?

      render 'index', formats: :json, handlers: 'jbuilder'
    end
  end
end
