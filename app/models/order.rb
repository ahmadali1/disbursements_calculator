class Order < ApplicationRecord
  FEE_LESS_THAN_50 = 0.01
  FEE_BETWEEN_50_300 = 0.095
  FEE_MORE_THAN_300 = 0.085

  belongs_to :merchant
  belongs_to :shopper
  belongs_to :disbursement, optional: true

  validates :shopper_id, :merchant_id, :amount, presence: true

  scope :not_disbursed, -> { where(disbursement_id: nil) }
  scope :completed_between, -> (start_date, end_date) { where(completed_at: start_date..end_date) }

  # Amount after applying sequra fee per order
  def amount_to_disburse
    if amount < 50
      amount * (1 - FEE_LESS_THAN_50)
    elsif amount <= 300
      amount * (1 - FEE_BETWEEN_50_300)
    else
      amount * (1 - FEE_MORE_THAN_300)
    end
  end
end
