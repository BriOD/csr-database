require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #index' do
    it 'renders the index view'
    it 'displays a list of IP ranges'
    it 'contains links to each IP range listed'
    it 'shows the total number of IP addresses available in a range'
    it 'shows the percentage of used ip addresses in a range'
  end
end
