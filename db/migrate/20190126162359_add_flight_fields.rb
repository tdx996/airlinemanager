class AddFlightFields < ActiveRecord::Migration[5.2]
  def change
  	add_column :flights, :src_airport_id, :integer
  	add_column :flights, :dst_airport_id, :integer
  	add_column :flights, :departure_at, :datetime
  	add_column :flights, :arrival_at, :datetime
  	add_column :flights, :seat_count, :datetime
  	add_column :flights, :price, :decimal
  	add_column :flights, :status, :string
  end
end
