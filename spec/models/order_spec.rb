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
end
