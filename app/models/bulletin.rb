class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :image, attached: true, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }

  scope :desc_by_created, -> { order(created_at: :desc) }
end
