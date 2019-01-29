class HomeController < ApplicationController

	include ApplicationHelper	

	def index

	end

	def dashboard
		with_format :html do
	    	@view = render_to_string :partial => 'home/dashboard', :locals => {}
		end
		render :json => { 
			:status => true,
			:view 	=> @view,
			:title 	=> t(:dashboard)
		}
	end
end
