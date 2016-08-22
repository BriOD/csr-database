require 'rails_helper'

RSpec.describe IprangeController, type: :controller do
  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'displays the current ip range as a breadcrumb'
    it 'shows the subnet mask and gateway of the current range'
    it 'lists all of the ip addresses available in that range'

    context 'for a single customer' do
      it 'shows their ip address'
      it 'shows their account number'
      it 'shows their full name'
      it 'shows their home phone number'
      context 'shows a button' do
        it 'to disconnect if the customer is active'
        it 'to reconnect if the customer is inactive'
      end
    end
  end
end
