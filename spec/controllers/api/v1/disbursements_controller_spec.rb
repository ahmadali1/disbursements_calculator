require 'rails_helper'

RSpec.describe Api::V1::DisbursementsController, type: :controller do
  describe 'GET #index' do
    before do
      Disbursement.create(
        amount: 100.10,
        merchant: Merchant.create(name: 'Merchant 1', cif: 'cif1', email: 'm1@gmail.com'),
        year: Time.current.year,
        week: Time.current.strftime('%U').to_i
      )
      Disbursement.create(
        amount: 100.20,
        merchant: Merchant.create(name: 'Merchant 2', cif: 'cif2', email: 'm2@gmail.com'),
        year: Time.current.year,
        week: Time.current.strftime('%U').to_i
      )
    end

    it 'returns all disbursements' do
      get :index
      json = JSON.parse(response.body)

      expect(json.count).to eq(2)
    end

    it 'returns disbursement of given merchant' do
      merchant = Merchant.first
      get :index, params: { merchant_id: merchant.id }

      json = JSON.parse(response.body)

      expect(json.count).to eq(1)
    end
  end
end
