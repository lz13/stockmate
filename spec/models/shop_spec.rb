require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:user) { create(:user) }
  let!(:shop) { create(:shop, name: 'Coffee House', location: 'Downtown', owner: user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:location).is_at_most(250) }

    it 'allows same name with different locations' do
      second_shop = build(:shop, name: 'Coffee House', location: 'Uptown', owner: user)
      expect(second_shop).to be_valid
    end

    it 'validates uniqueness of name scoped to location' do
      duplicate_shop = build(:shop, name: 'Coffee House', location: 'Downtown', owner: user)

      expect(duplicate_shop).not_to be_valid
      expect(duplicate_shop.errors[:name]).to include('has already been taken')
    end

    it 'allows blank location' do
      shop = build(:shop, name: 'Bakery', location: '', owner: user)
      expect(shop).to be_valid
    end

    it 'rejects location longer than 250 characters' do
      long_location = 'a' * 251
      shop = build(:shop, name: 'Bakery', location: long_location, owner: user)

      expect(shop).not_to be_valid
      expect(shop.errors[:location]).to include('is too long (maximum is 250 characters)')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:owner).class_name('User') }
    it { is_expected.to have_many(:products).dependent(:destroy) }
  end
end
