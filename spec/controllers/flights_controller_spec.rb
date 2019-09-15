require 'rails_helper'

RSpec.describe FlightsController, type: :controller do

    let(:current_user) { create(:confirmed_user) }
    before(:each) { sign_in current_user }
    after(:each)  { sign_out current_user}

    context 'GET #index' do
        it 'returns a success response' do
            get :index
            expect(response).to be_successfull
        end
    end

    context 'GET #show' do
        it 'returns a success response' do
            flight = Flight.create(attributes_for(:random_flight))
            get :show, params: { :id => flight.to_param }
            expect(response).to be_successfull
        end
    end

end
