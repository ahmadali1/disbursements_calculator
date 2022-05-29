require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  describe 'validations' do

    describe 'associations' do
      it { should have_many(:orders) }
      it { should belong_to(:merchant) }
    end

    describe 'validations' do
      it { should validate_presence_of(:amount) }
      it { should validate_presence_of(:year) }
      it { should validate_presence_of(:week) }
    end
  end
end
