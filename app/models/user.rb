# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins

  validates :email, presence: true, uniqueness: true
end
