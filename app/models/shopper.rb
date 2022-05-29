class Shopper < ApplicationRecord
  EMAIL_REGEX = /.+@.+\..+/.freeze

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :nif, presence: true
  validates :name, presence: true
end
