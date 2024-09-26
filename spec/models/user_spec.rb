# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  subject { user }

  describe 'when respond to email, password, etc' do
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:token) }
  end

  describe 'when email is presente' do
    it { should be_valid }
  end

  describe 'when email is not present' do
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:email) }
    it { should allow_value('email@domain.com').for(:email) }
    it { should validate_uniqueness_of(:token) }
  end

  describe '#generate_authentication_token!' do
    it 'generates a unique token' do
      token = 'r0dr1g0v3ntur1n1h4ss'
      allow(Devise).to receive(:friendly_token).and_return(token)      
      user.generate_authentication_token!
      expect(user.token).to eq(token)
    end

    it 'generates another token when one has been taken' do
      exist_user = FactoryBot.create(:user, token: 'v3ntur1n1h4ssr0dr1g0')
      user.generate_authentication_token!
      expect(user.token).not_to eq(exist_user.token)
    end
  end

  describe 'associations' do
    it { should have_many(:products) }
  end
end
