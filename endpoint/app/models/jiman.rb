class Jiman < ApplicationRecord
  has_many :category_jimen
  has_many :categories, through: :category_jimen
end
