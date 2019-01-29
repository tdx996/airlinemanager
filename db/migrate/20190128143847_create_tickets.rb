class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.references :flight, index: true
      t.references :passenger, index: true
      t.string :seat
      t.timestamps
    end
  end
end
