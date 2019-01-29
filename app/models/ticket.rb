class Ticket < ApplicationRecord
	belongs_to :passenger
	belongs_to :flight

	validates :passenger_id, presence: true
	validates :seat, presence: true
	validate :validate_passenger

	private def validate_passenger
		errors.add(:passenger_id, "already has a ticket for this flight.") unless Ticket.where(flight_id: self.flight_id).where(passenger_id: self.passenger_id).count == 0
	end

end
