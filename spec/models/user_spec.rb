require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User' do
    it 'has a valid factory'
    it 'is invalid without a first name'
    it 'is invalid without a last name'
    it 'returns a contacts full name as a string'
    it 'is invalid without an email'
  end
end
