class Merchant < ApplicationRecord
  EMAIL_REGEX = /.+@.+\..+/.freeze

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :cif, presence: true
  validates :name, presence: true
end
