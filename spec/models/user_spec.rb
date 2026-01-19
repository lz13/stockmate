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

        expect(user.errors[:email]).to include('is invalid')
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
end
