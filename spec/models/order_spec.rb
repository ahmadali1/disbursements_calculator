require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'associations' do
    it { should belong_to(:merchant) }
    it { should belong_to(:shopper) }
    it { should belong_to(:disbursement).optional }
  end

  describe '#amount_to_disburse' do
    it 'applies 1% fee for order less than 50' do
      expect(described_class.new(amount: 49).amount_to_disburse).to(
        eq(48.51)
      )
    end

    it 'applies 0.95% fee for order between 50 - 300' do
      expect(described_class.new(amount: 299).amount_to_disburse).to(
        eq(270.595)
      )
    end

    it 'applies 0.85% fee for order over 300' do
      expect(described_class.new(amount: 450).amount_to_disburse).to(
        eq(411.75)
      )
    end
  end
end
