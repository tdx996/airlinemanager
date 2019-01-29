class AddPassengerFields < ActiveRecord::Migration[5.2]
  def change
  	add_column :passengers, :firstname, :string
  	add_column :passengers, :lastname, :string
  end
end
