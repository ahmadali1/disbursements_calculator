class Disbursement < ApplicationRecord
  belongs_to :merchant
  has_many :orders

  validates :amount, :year, presence: true, numericality: true
  validates :week, presence: true, uniqueness: { scope: %i[merchant_id year] }, numericality: true
end
