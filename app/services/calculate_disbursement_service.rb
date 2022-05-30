class CalculateDisbursementService

  def initialize(merchant, year, week_number)
    @year = year
    @week_number = week_number
    @merchant = merchant
  end

  def call
    total = 0
    orders_not_disbursed = @merchant.orders.not_disbursed.completed_between(week_start, week_end)
    return if orders_not_disbursed.blank?

    orders_not_disbursed.find_each do |order|
      total += order.amount_to_disburse
    end

    disbursement = build_disbursement
    disbursement.amount = disbursement.amount.to_f + total

    Disbursement.transaction do
      disbursement.save!
      orders_not_disbursed.update_all(disbursement_id: disbursement.id)
    end
  end

  private

  def week_start
    Date.commercial(@year, @week_number, 1).beginning_of_day
  end

  def week_end
    Date.commercial(@year, @week_number, 7).end_of_day
  end

  def build_disbursement
    Disbursement.where(
      merchant: @merchant,
      week: @week_number,
      year: @year
    ).first_or_initialize
  end
end