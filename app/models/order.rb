class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper
  belongs_to :disbursement, optional: true

  validates :shopper_id, :merchant_id, :amount, presence: true
end
