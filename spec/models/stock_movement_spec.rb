require 'rails_helper'

RSpec.describe StockMovement, type: :model do
  let(:user) { create(:user) }
  let(:shop) { create(:shop, owner: user) }
  let(:product) { create(:product, shop: shop) }
  subject(:stock_movement) { build(:stock_movement, product: product) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:change) }
    it { is_expected.to validate_numericality_of(:change).is_other_than(0) }

    it { is_expected.to validate_presence_of(:movement_type) }

    it { is_expected.to validate_presence_of(:reason) }
    it { is_expected.to validate_length_of(:reason).is_at_most(500) }

    it 'rejects zero change' do
      stock_movement.change = 0
      expect(stock_movement).not_to be_valid
      expect(stock_movement.errors[:change]).to include('must be other than 0')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:movement_type).with_values(inbound: 0, outbound: 1, adjustment: 2) }

    it 'creates inbound movement using default factory' do
      movement = create(:stock_movement, product: product)
      expect(movement.movement_type).to eq('inbound')
      expect(movement.change).to eq(10)
      expect(movement.reason).to eq('Initial stock')
    end

    it 'creates outbound movement using trait' do
      movement = create(:stock_movement, :out, product: product)
      expect(movement.movement_type).to eq('outbound')
      expect(movement.change).to eq(5)
      expect(movement.reason).to eq('Customer order')
    end

    it 'creates adjustment movement using trait' do
      movement = create(:stock_movement, :adjustment, product: product)
      expect(movement.movement_type).to eq('adjustment')
      expect(movement.change).to eq(-3)
      expect(movement.reason).to eq('Inventory correction')
    end
  end
end
