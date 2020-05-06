# frozen_string_literal: true

# Jiman model Class
class Jiman < ApplicationRecord
  has_many :category_jimen, dependent: :destroy
  has_many :categories, through: :category_jimen
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
  validates :image, presence: true
  validates :access, numericality: { only_integer: true }, allow_blank: true
  validates :star, numericality: true, allow_blank: true

  # increment jiman access counter
  def increment_access
    update! access: access + 1
  end
end
