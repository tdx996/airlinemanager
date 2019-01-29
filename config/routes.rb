Rails.application.routes.draw do

	resources :users

	resources :sessions, only: [:new, :create, :destroy]
	get 'login', to: 'sessions#new', as: 'login'
	get 'logout', to: 'sessions#destroy', as: 'logout'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 'home#index', as: 'home'

	get 'dashboard' => 'home#dashboard', as: 'dashboard'

	get '/flights/list' => 'flights#list', as: 'flights_list'

	resources :flights do 
		resources :tickets
	end

	get '/flights/:id/seats' => 'flights#seats', as: 'flight_seats'
	get '/flights/:id/basic-info' => 'flights#basic_info', as: 'flights_basic_info'
	get '/flights/:id/passengers' => 'flights#passengers', as: 'flights_passengers'

	get '/passengers/autocomplete' => 'passengers#autocomplete', as: 'passengers_autocomplete'
	get '/airports/autocomplete' => 'airports#autocomplete', as: 'airports_autocomplete'

	get '/jobs/populate-airports' => 'jobs#populate_airports', as: 'jobs_populate_airports'

end
