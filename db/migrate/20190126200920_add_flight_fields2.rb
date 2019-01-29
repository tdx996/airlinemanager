class AddFlightFields2 < ActiveRecord::Migration[5.2]
  def change
  	execute <<-SQL
        ALTER TABLE flights ADD status enum('ready_to_book', 'boarding', 'taking_off', 'in_air', 'landing', 'waiting');
    SQL
    add_column :flights, :seats_count, :integer
  end
end
