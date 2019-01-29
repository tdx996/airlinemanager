class Ticket < ApplicationRecord
	belongs_to :passenger
	belongs_to :flight

	validates :passenger_id, presence: true
	validate :validate_passenger
	validates :seat, presence: true
	validate :validate_seat

	private def validate_passenger
		if self.new_record?
			errors.add(:passenger_id, "already has a ticket for this flight.") unless Ticket.where(flight_id: self.flight_id).where(passenger_id: self.passenger_id).count == 0
		else
			errors.add(:passenger_id, "already has a ticket for this flight.") unless Ticket.where(flight_id: self.flight_id).where(passenger_id: self.passenger_id).where.not(id: self.id).count == 0
		end
	end

	private def validate_seat
		if self.new_record?
			errors.add(:seat, "is already taken on this flight") unless Ticket.where(flight_id: self.flight_id).where(seat: self.seat).count() == 0
		else
			errors.add(:seat, "is already taken on this flight") unless Ticket.where(flight_id: self.flight_id).where(seat: self.seat).where.not(id: self.id).count() == 0
		end		

		# seat exists
		errors.add(:seat, "doesn't exist on this flight") unless self.flight.allSeats.include?(self.seat)
	end	

end
