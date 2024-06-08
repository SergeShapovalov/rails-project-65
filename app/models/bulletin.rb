class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :image, attached: true, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }

  scope :desc_by_created, -> { order(created_at: :desc) }

  aasm whiny_transitions: false, column: :state do
    state :draft, initial: true
    state :under_moderation, :published, :archived, :rejected

    event :moderate do
      transitions from: %i[draft rejected], to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id title state]
  end

  def self.ransackable_scopes(_auth_object = nil)
    %i[by_creation_date_desc]
  end
end
