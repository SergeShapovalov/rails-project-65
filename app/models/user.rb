class User < ApplicationRecord
  has_many :announcement

  has_secure_password
end
