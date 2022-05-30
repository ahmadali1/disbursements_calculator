require 'sidekiq-scheduler'

class CalculateDisbursementsJob < ApplicationJob
  queue_as :default

  def perform(week = Time.current.strftime('%U').to_i, year = Time.current.year)
    Merchant.find_each do |merchant|
      CalculateDisbursementForMerchantJob.perform_later(merchant.id, year, week)
    end
  end
end