class TicketsController < ApplicationController

	include ApplicationHelper

	def new

	end

	def create
		@flight = Flight.find(params[:flight_id])

		if @flight.airline_id != current_user.airline_id
			abort "Not allowed"
		end

		@ticket = @flight.tickets.new(ticket_params)

		if (@ticket.save)
			render :json => { :status => true }
		else
			with_format :html do
		    	@view = render_to_string :partial => 'partials/messages', :locals => { errors: @ticket.errors}
			end
			render :json => {
				:status => false,
				:errors => @view
			}
		end
	end

	def edit 
		@flight = Flight.find(params[:flight_id])

		if @flight.airline_id != current_user.airline_id
			abort "Not allowed"
		end

		@ticket = Ticket.find(params[:id])
		@seats = @flight.availableSeats
		@seats[@ticket.seat] = @ticket.seat;

		with_format :html do
	    	@view = render_to_string :partial => 'tickets/edit', :locals => { 
	    		flight: @flight, 
	    		ticket: @ticket,
	    		tickets: @flight.tickets, 
	    		seats: @seats
	    	}
		end
		render :json => {
			:status => true,
			:view 	=> @view
		}
	end

	def update
		@flight = Flight.find(params[:flight_id])

		if @flight.airline_id != current_user.airline_id
			abort "Not allowed"
		end

		@ticket = Ticket.find(params[:id])

		if (@ticket.update(ticket_params))
			render :json => { :status => true }
		else
			with_format :html do
		    	@view = render_to_string :partial => 'partials/messages', :locals => { errors: @ticket.errors}
			end
			render :json => {
				:status => false,
				:errors => @view
			}
		end
	end

	def destroy
		@flight = Flight.find(params[:flight_id])

		if @flight.airline_id != current_user.airline_id
			abort "Not allowed"
		end

		@ticket = Ticket.find(params[:id])
		@ticket.destroy

		render :json => { :status => true }
	end

	private def ticket_params
		params.require(:ticket).permit(:passenger_id, :seat)
	end
end
