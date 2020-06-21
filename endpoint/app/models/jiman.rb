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

  class << self
    def save_jiman(jiman, user_id, params)
      Jiman.transaction do
        jiman.updated_data = params
        jiman.user_id = user_id
        jiman.base64image = params[:imagedata] if params[:imagedata].present?
        jiman.reresist_categories(params[:categories])
        jiman.save!
      end
    end
  end

  # increment jiman access counter
  def increment_access
    update! access: access + 1
  end

  def updated_data=(data)
    self.title = data[:title]
    self.description = data[:description]
    self.url = data[:url]
    self.point1 = data[:point1]
    self.point2 = data[:point2].present? ? data[:point2] : nil
    self.point3 = data[:point3].present? ? data[:point3] : nil
    self.point4 = data[:point4].present? ? data[:point4] : nil
  end

  def base64image=(data)
    io = CarrierStringIO.new(
      data[:name],
      data[:type],
      Base64.decode64(data[:base64data])
    )
    self.image = io
  end

  def reresist_categories(categories)
    self.categories.delete_all if self.categories.present?
    categories.each do |c|
      catg = Category.find(c[:id])
      self.categories.push catg if catg.present?
    end
  end

  private

  def image_size
    errors.add(:image, 'should be less than 4MB') if image.size > 4.megabytes
  end
end
