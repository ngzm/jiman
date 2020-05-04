class Category < ApplicationRecord
  has_many :category_jimen
  has_many :jimen, through: :category_jimen
end
