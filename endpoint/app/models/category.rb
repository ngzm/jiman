# frozen_string_literal: true

# Category model Class
class Category < ApplicationRecord
  has_many :category_jimen, dependent: :destroy
  has_many :jimen, through: :category_jimen
end
