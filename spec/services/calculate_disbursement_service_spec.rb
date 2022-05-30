require 'rails_helper'

RSpec.describe CalculateDisbursementService do
  subject(:disbursement_service) { described_class.new(merchant, year, week) }

  describe '#call' do
    let(:year) { 2018 }
    let(:week) { 1 }
    let(:shopper) { Shopper.create(name: 'Shopper', email: 'a@a.com', nif: '123123') }
    let(:merchant) { Merchant.create(name: 'Merchant', email: 'b@b.com', cif: '123123') }

    context 'when there are no orders' do
      before do
        disbursement_service.call
      end

      it "creates no disbursements" do
        expect(Disbursement.count).to eq 0
      end
    end

    context 'when there are orders but not disbursement' do
      before do
        Order.create(shopper: shopper, merchant: merchant, amount: 10, completed_at: DateTime.new(year, week, 3, 10, 0, 0))
        Order.create(shopper: shopper, merchant: merchant, amount: 10, completed_at: DateTime.new(2017, 1, 1, 10, 0, 0))
        Order.create(shopper: shopper, merchant: merchant, amount: 10, completed_at: DateTime.new(year, week, 2, 20, 0, 0))
        disbursement_service.call
      end

      it 'creates disbursement' do
        expect(Disbursement.count).to eq 1
      end

      it 'calculates correct disbursement amount' do
        expect(Disbursement.last.amount).to eq 19.8
      end
    end

    context 'when there are orders and disbursement' do
      before do
        disbursement = Disbursement.create(merchant: merchant, week: week, year: year, amount: 20)
        Order.create(shopper: shopper, merchant: merchant, amount: 10, disbursement_id: disbursement.id)
        Order.create(shopper: shopper, merchant: merchant, amount: 10, completed_at: DateTime.new(year, week, 3, 10, 0, 0))
        disbursement_service.call
      end

      it 'updates correct disbursement amount' do
        expect(Disbursement.last.amount).to eq 29.9
      end
    end
  end
end
