# frozen_string_literal: true

# User model Class
class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :jimen, through: :reviews

  validates :name, presence: true
  validates :identifer, uniqueness: true, allow_nil: true
end
