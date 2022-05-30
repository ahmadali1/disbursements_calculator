class CalculateDisbursementForMerchantJob < ApplicationJob
  queue_as :default

  def perform(merchant_id, year, week)
    CalculateDisbursementService.new(
      Merchant.find(merchant_id), year, week
    ).call
  end
end