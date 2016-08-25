require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:user)).to be_valid
    end

    it 'is invalid without a first name' do
      expect(FactoryGirl.build(:user, first_name: nil)).to_not be_valid
    end

    it 'is invalid without a last name' do
      expect(FactoryGirl.build(:user, last_name: nil)).to_not be_valid
    end

    it 'returns a contacts full name as a string' do
      user = FactoryGirl.build(:user, first_name: 'John', last_name: 'Doe')
      expect(user.name).to eq('John Doe')
    end

    it 'is invalid without an email' do
      expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
    end
  end

  describe 'methods' do
    it '.create'
  end
end
