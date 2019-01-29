class FlightsController < ApplicationController

	include ApplicationHelper

	def index
		@flights = Flight.pagination(params, current_user)

		@airports = Airport.limit(50).all

		# return view in JSON
		with_format :html do
	    	@view = render_to_string :partial => 'flights/index', :locals => { flights: @flights, airports: @airports}
		end
		render :json => { 
			:status => true,
			:view 	=> @view,
			:title	=> t(:flights)
		}
	end

	def list
		@flights = Flight.pagination(params, current_user)

		# return view in JSON
		with_format :html do
	    	@view = render_to_string :partial => 'flights/list', :locals => { flights: @flights}
		end
		render :json => { 
			:status => true,
			:view 	=> @view,
		}
	end

	def show
		@flight = Flight.find(params[:id])

		@tickets = @flight.tickets

		# return view in JSON
		with_format :html do
	    	@view = render_to_string :partial => 'flights/show', :locals => { flight: @flight, tickets: @tickets}
		end
		render :json => { 
			:status => true,
			:view 	=> @view,
			:title	=> t(:flight_id, id: @flight.id)
		}
	end

	def create
		@flight = current_user.airline.flights.create(flight_params)
		if (@flight.save)
			render :json => {
				:status => true
			}
		else
			# return view in JSON
			with_format :html do
		    	@view = render_to_string :partial => 'partials/messages', :locals => { errors: @flight.errors}
			end
			render :json => {
				:status => false,
				:errors => @view
			}
		end
	end

	def basic_info
		@flight = Flight.find(params[:id])

		# return view in JSON
		with_format :html do
	    	@view = render_to_string :partial => 'flights/basic_info', :locals => { flight: @flight}
		end
		render :json => {
			:status => true,
			:view 	=> @view
		}
	end

	def passengers
		@flight = Flight.find(params[:id])

		with_format :html do
	    	@view = render_to_string :partial => 'flights/passengers', :locals => { flight: @flight, tickets: @flight.tickets, seats: @flight.availableSeats}
		end
		render :json => {
			:status => true,
			:view 	=> @view
		}
	end

	def seats
		@flight = Flight.find(params[:id])

		render :json => {
			:status => true,
			:options => @flight.availableSeats.collect.collect{ |a| {
				id: a[0],
				text: a[0]
			}}
		}
	end

	def edit
		@flight = Flight.find(params[:id])

		# return view in JSON
		with_format :html do
	    	@view = render_to_string :partial => 'flights/edit', :locals => { flight: @flight, airports: Airport.limit(50).all}
		end
		render :json => { 
			:status => true,
			:view 	=> @view,
		}
	end

	def update
		@flight = Flight.find(params[:id])

		if (@flight.update(flight_params))
			render :json => {
				:status => true
			}
		else
			# return view in JSON
			with_format :html do
		    	@view = render_to_string :partial => 'partials/messages', :locals => { errors: @flight.errors}
			end
			render :json => {
				:status => false,
				:errors => @view
			}
		end
	end

	private def flight_params
		params.require(:flight).permit(:src_airport_id, :dst_airport_id, :arrival_at, :departure_at, :price, :capacity)
	end

end
