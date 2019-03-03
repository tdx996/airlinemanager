# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# Users
# CSV.foreach(Rails.root.join('db/seeds/users.csv'), headers: false) do |row|
#     User.create! do |a|
# 		a.airline_id = row[0]
# 		a.email = row[1]
# 		a.password = row[2]
# 	end
# end

# Passengers
# CSV.foreach(Rails.root.join('db/seeds/passengers.csv'), headers: false) do |row|
#     Passenger.create! do |a|
# 		a.firstname = row[0]
# 		a.lastname = row[1]
# 	end
# end

# Airports
# CSV.foreach(Rails.root.join('db/seeds/airports.csv'), headers: false) do |row|
#     Airport.create! do |a|
# 		a.id = row[0]
# 		a.name = row[1]
# 		a.city = row[2]
# 		a.country = row[3]
# 		a.lat = row[6]
# 		a.lng = row[7]
# 		a.alt = row[8]
# 		a.timezone = row[9]
# 	end
# end

# Airlines
# CSV.foreach(Rails.root.join('db/seeds/airlines.csv'), headers: false) do |row|
#     Airline.create! do |a|
# 		a.id = row[0]
# 		a.name = row[1]
# 		a.alias = row[2]
# 	end
# end