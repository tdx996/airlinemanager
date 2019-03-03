require 'rails_helper'

RSpec.describe FlightsController, type: :controller do
    before(:each) do
        create(:random_user)
    end

    context 'GET #index' do
        it 'returns a success response' do
            # debugger
            # sign_in User.first
            get :index
            expect(response).to be_success
        end
    end

    context 'GET #show' do
        it 'returns a success response' do
            sign_in User.first
            flight = Flight.create(attributes_for(:random_flight))
            get :show, params: { :id => flight.to_param }
            expect(response).to be_success
        end
    end
end
