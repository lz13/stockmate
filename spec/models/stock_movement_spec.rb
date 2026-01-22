require 'rails_helper'

RSpec.describe StockMovement, type: :model do
  subject(:stock_movement) { build(:stock_movement, product: product) }

  let(:user) { create(:user) }
  let(:shop) { create(:shop, owner: user) }
  let(:product) { create(:product, shop: shop) }


  describe 'validations' do
    it { is_expected.to validate_presence_of(:change) }
    it { is_expected.to validate_numericality_of(:change).is_other_than(0) }

    it { is_expected.to validate_presence_of(:movement_type) }

    it { is_expected.to validate_presence_of(:reason) }
    it { is_expected.to validate_length_of(:reason).is_at_most(500) }

    context 'when validating change' do
      it 'rejects zero change' do
        stock_movement.change = 0
        expect(stock_movement).not_to be_valid
      end

      it 'adds error for zero change' do
        stock_movement.change = 0
        stock_movement.valid?

        expect(stock_movement.errors[:change]).to include('mora biti različito od 0')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:movement_type).with_values(inbound: 0, outbound: 1, adjustment: 2) }

    context 'when checking inbound enum value' do
      it 'creates inbound movement using default factory' do
        movement = create(:stock_movement, product: product)
        expect(movement.movement_type).to eq('inbound')
      end

      it 'creates inbound movement change value using default factory' do
        movement = create(:stock_movement, product: product)
        expect(movement.change).to eq(10)
      end

      it 'creates inbound movement reason using default factory' do
        movement = create(:stock_movement, product: product)
        expect(movement.reason).to eq('Initial stock')
      end
    end

    context 'when checking outbound enum value' do
      it 'creates outbound movement using default factory' do
        movement = create(:stock_movement, :out, product: product)
        expect(movement.movement_type).to eq('outbound')
      end

      it 'creates outbound movement change value using default factory' do
        movement = create(:stock_movement, :out, product: product)
        expect(movement.change).to eq(5)
      end

      it 'creates outbound movement reason using default factory' do
        movement = create(:stock_movement, :out, product: product)
        expect(movement.reason).to eq('Customer order')
      end
    end

    context 'when checking adjustment enum value' do
      it 'creates adjustment movement using default factory' do
        movement = create(:stock_movement, :adjustment, product: product)
        expect(movement.movement_type).to eq('adjustment')
      end

      it 'creates adjustment movement change value using default factory' do
        movement = create(:stock_movement, :adjustment, product: product)
        expect(movement.change).to eq(-3)
      end

      it 'creates adjustment movement reason using default factory' do
        movement = create(:stock_movement, :adjustment, product: product)
        expect(movement.reason).to eq('Inventory correction')
      end
    end
  end
end
