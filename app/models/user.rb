class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true, on: :update

  has_many :evaluations
  has_many :white_bread_stores
  has_one_attached :avatar
  has_one_attached :image
  has_many :favorites
  has_many :favorite_white_bread_stores, through: :favorites, source: :white_bread_store

  before_create :default_image

  def default_image
    if !self.avatar.attached? && self.avatar.blob.blank?
      default_image_path = Rails.root.join('app', 'assets', 'images', 'default_icon.png')
      self.avatar.attach(io: File.open(default_image_path), filename: 'default_icon.png', content_type: 'image/png')
    end
  end

  def favorite(white_bread_store)
    favorites.create(white_bread_store: white_bread_store)
  end

  def unfavorite(white_bread_store)
    favorites.find_by(white_bread_store: white_bread_store).destroy
  end

  def favorite?(white_bread_store)
    favorite_white_bread_stores.exists?(white_bread_store.id)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def guest?
    email == 'guest@example.com'
  end
end
