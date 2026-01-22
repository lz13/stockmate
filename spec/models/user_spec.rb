require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    context 'when validation email' do
      it 'validates email format' do
        user.email = 'invalid_email'

        expect(user).not_to be_valid
      end

      it 'adds error for invalid email format' do
        user.email = 'invalid_email'
        user.valid?

        expect(user.errors[:email]).to include('nije valjano')
      end

      it 'accepts valid email format' do
        valid_emails = %w[user@example.com test@userdomain.co.uk user+tag@example.org]

        valid_emails.each do |email|
          user.email = email
          expect(user).to be_valid, "#{email.inspect} should be valid"
        end
      end

      it 'rejects invalid email formats' do
        invalid_emails = %w[plainaddress @missingusername.com user@ user@domain..com user@.com]

        invalid_emails.each do |email|
          user.email = email
          expect(user).not_to be_valid, "#{email.inspect} should be invalid"
        end
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:shops).with_foreign_key(:owner_id).dependent(:destroy) }

    it 'destroys associated shops when user is deleted' do
      user = create(:user)
      shop = create(:shop, owner: user)

      expect { user.destroy }.to change(Shop, :count).by(-1)
    end
  end

  describe 'admin functionality' do
    it 'returns false for admin? when admin is false' do
      user = build(:user, admin: false)
      expect(user).not_to be_admin
    end

    it 'returns true for admin? when admin is true' do
      user = build(:user, :admin)
      expect(user).to be_admin
    end
  end

  describe '.admins scope' do
    context 'when there are no admin users' do
      it 'returns an empty collection' do
        create(:user)
        expect(described_class.admins).to be_empty
      end

      it 'does not include non-admin users' do
        admin_user = create(:user, :admin)
        regular_user = create(:user)

        # expect(described_class.admins).to include(admin_user)
        expect(described_class.admins).not_to include(regular_user)
      end
    end
  end
end
