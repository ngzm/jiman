# frozen_string_literal: true

# define class that extends IO with methods that are required by carrierwave
class CarrierStringIO < StringIO
  attr_accessor :original_filename, :content_type

  def initialize(original_filename, content_type, data)
    super(data)
    @original_filename = original_filename
    @content_type = content_type
  end
end

# Jiman model Class
class Jiman < ApplicationRecord
  belongs_to :user
  has_many :category_jimen, dependent: :destroy
  has_many :categories, through: :category_jimen
  has_many :reviews, dependent: :destroy
  has_many :review_users, through: :reviews, source: 'user'

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :url, presence: true
  validates :point1, presence: true
  validates :access, numericality: { only_integer: true }, allow_blank: true
  validates :star, numericality: true, allow_blank: true
  validate :image_size

  # increment jiman access counter
  def increment_access
    update! access: access + 1
  end

  def image_text(file_name, content_type, text)
    puts '=============='
    puts file_name
    puts content_type
    puts text
    puts '=============='
    io = CarrierStringIO.new(file_name, content_type, Base64.decode64(text))
    self.image = io
  end

  private

  def image_size
    errors.add(:image, 'should be less than 4MB') if image.size > 4.megabytes
  end
end
