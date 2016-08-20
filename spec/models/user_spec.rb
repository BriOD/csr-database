require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:user)).to be_valid
    end

    it 'is invalid without a first name' do
      # expect(FactoryGirl.build(:user, first_name: nil)).to_not be_valid
    end
    #
    # it 'is invalid without a last name' do
    #
    # end
    #
    # it 'returns a contacts full name as a string' do
    #
    # end
    #
    # it 'is invalid without an email'
  end
end
