class AirportsController < ApplicationController
	def autocomplete
		search = "%#{params[:search]}%"
		@list =  Airport
			.where("name LIKE ?", search)
			.limit(50)
			.all
			.collect{ |a| {
				id: a.id,
				text: a.name
			}}
		render :json => { 
			:status 	=> true,
			:results 	=> @list,
		}
	end
end
