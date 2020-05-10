# frozen_string_literal: true

# User model Class
class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :jimen, through: :reviews
  has_many :accounts, dependent: :destroy

  validates :name, presence: true
  validates :email, uniqueness: true

  class << self
    def update_or_create_user_by_userinfo(userinfo)
      user = User.find_by(email: userinfo[:email])
      if user.present?
        user.name = userinfo[:name]
        user.full_name = userinfo[:full_name]
        user.image = userinfo[:image]
      else
        user = User.new(
          name: userinfo[:name],
          full_name: userinfo[:full_name],
          email: userinfo[:email],
          image: userinfo[:image]
        )
      end
      user.save!
      user
    end
  end
end
