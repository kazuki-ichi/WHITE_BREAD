class WhiteBreadStore < ApplicationRecord
  belongs_to :user
  has_many :evaluations

  has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user

  has_one_attached :image
  before_create :default_image

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validates :price, numericality: { greater_than: 1 }, on: :create

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def default_image
    if !self.image.attached?
      self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_white_bread.png')), filename: 'default_white_bread.png', content_type: 'image/png')
    end
  end

  private

  def end_time_after_start_time
    if start_time.present? && end_time.present? && end_time <= start_time
      errors.add(:end_time, "は営業開始時間より後に設定してください")
    end
  end
end
