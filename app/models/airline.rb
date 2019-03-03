class Airline < ApplicationRecord
	has_many :flights
	has_many :users
end
