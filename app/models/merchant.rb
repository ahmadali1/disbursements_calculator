class Merchant < ApplicationRecord
  EMAIL_REGEX = /.+@.+\..+/.freeze

  has_many :orders
  has_many :disbursements, dependent: :destroy
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :cif, presence: true
  validates :name, presence: true
end
