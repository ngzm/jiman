# frozen_string_literal: true

# Review model Class
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :jiman

  validates :jiman_id,
            presence: true,
            numericality: { only_integer: true, allow_blank: true }

  validates :user_id,
            presence: true,
            numericality: { only_integer: true, allow_blank: true }

  validates :star,
            presence: true,
            inclusion: { in: (0..5).to_a, allow_blank: true }

  def save_review
    Review.transaction do
      save!
      update_jiman_star
    end
  end

  def update_review(review)
    Review.transaction do
      update! review
      update_jiman_star
    end
  end

  def update_jiman_star
    star_avg = Review.where(jiman_id: jiman_id).average(:star)
    jiman.update!(star: star_avg)
  end
end
