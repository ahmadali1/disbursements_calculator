class Shopper < ApplicationRecord
  EMAIL_REGEX = /.+@.+\..+/.freeze # URI::MailTo::EMAIL_REGEXP can also be used

  has_many :orders
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :nif, presence: true
  validates :name, presence: true
end
