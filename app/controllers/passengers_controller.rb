class PassengersController < ApplicationController
	def autocomplete 
		search = "%#{params[:q]}%"
		@list =  Passenger
			.where("CONCAT(firstname, ' ', lastname) LIKE ?", search)
		    .joins("LEFT JOIN tickets ON tickets.passenger_id = passengers.id AND tickets.flight_id = " + params[:flight_id])
			.where('tickets.id IS NULL')
			.limit(10)
			.all
			.collect{ |x| {
				label: x.firstname + " " + x.lastname, 
				value: x.id
			}}
		render :json => { 
			:status => true,
			:list 	=> @list,
		}
	end
end
