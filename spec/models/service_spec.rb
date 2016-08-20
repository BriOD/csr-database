require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'Service' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:service)).to be_valid
    end

    it 'is invalid without a service icon' do
      expect(FactoryGirl.build(:service, icon: nil)).to_not be_valid
    end

    it 'is invalid without a main type' do
      expect(FactoryGirl.build(:service, main_type: nil)).to_not be_valid
    end

    it 'is invalid without a main name' do
      expect(FactoryGirl.build(:service, main_name: nil)).to_not be_valid
    end

    it 'must have a unique sub-service type and name' do
      expect(FactoryGirl.create(:service, icon: 'desktop')).to be_valid
      expect(FactoryGirl.build(:service)).to_not be_valid
      expect(FactoryGirl.create(:service, sub_type: 'dsl', sub_name: 'DSL')).to be_valid
    end

    it '.name will return the sub_name unless sub_name is blank/nil then it returns the main_name' do
      service1 = FactoryGirl.create(:service, main_name: 'DSL', sub_name: nil)
      expect(service1.name).to eq('DSL')

      service2 = FactoryGirl.create(:service, main_name: 'DSL', sub_type: 'Other', sub_name: 'Wireless')
      expect(service2.name).to eq('Wireless')
    end
  end
end
