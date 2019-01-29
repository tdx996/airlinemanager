class Passenger < ApplicationRecord
	has_many :tickets

	def fullname
		"#{self.firstname} #{self.lastname}"
	end
end
