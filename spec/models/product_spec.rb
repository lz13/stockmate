require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { build(:product, shop: shop) }

  let(:user) { create(:user) }
  let(:shop) { create(:shop, owner: user) }


  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price_in_cents) }
    it { is_expected.to validate_presence_of(:stock_quantity) }

    it { is_expected.to validate_numericality_of(:price_in_cents).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:stock_quantity).is_greater_than_or_equal_to(0) }

    context 'when validating zero price' do
      it 'rejects zero price' do
        product.price = 0.0
        expect(product).not_to be_valid
      end

      it 'adds appropriate error message' do
        product.price = 0.0
        product.valid?

        expect(product.errors[:price_in_cents]).to include('mora biti veće od 0')
      end
    end

    context 'when validating negative price' do
      it 'rejects negative price' do
        product.price = -5.99
        expect(product).not_to be_valid
      end

      it 'adds appropriate error message' do
        product.price = -5.99
        product.valid?
        expect(product.errors[:price_in_cents]).to include('mora biti veće od 0')
      end
    end

    context 'when validating zero stock quantity' do
      it 'allows zero stock quantity' do
        product.stock_quantity = 0
        expect(product).to be_valid
      end
    end

    context 'when validating positive stock quantity' do
      it 'rejects negative stock quantity' do
        product.stock_quantity = -10
        expect(product).not_to be_valid
      end

      it 'adds appropriate error message' do
        product.stock_quantity = -10
        product.valid?

        expect(product.errors[:stock_quantity]).to include('mora biti veće ili jednako 0')
      end
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
