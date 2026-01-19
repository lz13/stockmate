require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { create(:user) }
  let(:shop) { create(:shop, owner: user) }
  subject(:product) { build(:product, shop: shop) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price_in_cents) }
    it { is_expected.to validate_presence_of(:stock_quantity) }

    it { is_expected.to validate_numericality_of(:price_in_cents).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:stock_quantity).is_greater_than_or_equal_to(0) }

    it 'rejects zero price' do
      product.price = 0
      expect(product).not_to be_valid
      expect(product.errors[:price_in_cents]).to include('must be greater than 0')
    end

    it 'rejects negative price' do
      product.price = -5.99
      expect(product).not_to be_valid
      expect(product.errors[:price_in_cents]).to include('must be greater than 0')
    end

    it 'allows zero stock quantity' do
      product.stock_quantity = 0
      expect(product).to be_valid
    end

    it 'rejects negative stock quantity' do
      product.stock_quantity = -10
      expect(product).not_to be_valid
      expect(product.errors[:stock_quantity]).to include('must be greater than or equal to 0')
    end
  end

  describe 'price conversion' do
    it 'converts price_in_cents to euros' do
      product.price_in_cents = 1099
      expect(product.price).to eq(10.99)
    end

    it 'converts euros to price_in_cents' do
      product.price = 15.75
      expect(product.price_in_cents).to eq(1575)
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:shop) }
    it { is_expected.to have_many(:stock_movements).dependent(:destroy) }

    it 'destroys associated stock movements when product is deleted' do
      product = create(:product, shop: shop)
      stock_movement = create(:stock_movement, product: product)

      expect { product.destroy }.to change(StockMovement, :count).by(-1)
    end
  end
end
