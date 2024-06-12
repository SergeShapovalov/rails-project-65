class Category < ApplicationRecord
  has_many :bulletins

  validates :name, uniqueness: true
end
