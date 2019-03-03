class AirlinesController < ApplicationController
	def autocomplete
		search = "%#{params[:search]}%"
		@list =  Airline
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
