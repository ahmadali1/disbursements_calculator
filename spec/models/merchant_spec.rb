require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    subject do
      described_class.new(
        email: 'random@email.com',
        name: 'random Name',
        cif: 'someciff'
      )
    end

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cif) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    describe 'email format' do
      context 'with valid format' do
        it 'returns valid entry' do
          expect(subject).to be_valid
        end
      end

      context 'with invalid format' do
        before do
          subject.email = 'invalid format'
        end

        it 'returns invalid entry' do
          expect(subject).not_to be_valid
        end
      end
    end
  end
end
