require 'rails_helper'

RSpec.describe User, type: :model do
    context 'validation tests' do
        it 'ensures email presence' do
            user = build(:user, email: nil)
            expect(user).to_not be_valid
        end

        it 'ensures airline presence' do
            user = build(:user, airline_id: nil)
            expect(user).to_not be_valid
        end

        it 'ensures password presence' do
            user = build(:user, password: nil)
            expect(user).to_not be_valid
        end

        it 'should save successfully' do
            user = build(:random_user)
            expect(user).to be_valid
        end
    end

    context 'scope tests' do
        before(:each) do
            create(:random_user)
            create(:random_user)
            create(:random_user)
            create(:random_user)
            User.create(attributes_for(:random_user)).update(:confirmation_token => nil)
            User.create(attributes_for(:random_user)).update(:confirmation_token => nil)
            User.create(attributes_for(:random_user)).update(:confirmation_token => nil)
        end

        it 'should return confirmed users' do
            User.all
            expect(User.confirmed_users.size).to eq(3)
        end

        it 'should return unconfirmed users' do
            expect(User.unconfirmed_users.size).to eq(4)
        end
    end
end
