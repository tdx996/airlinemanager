	class CreateAirlines < ActiveRecord::Migration[5.2]
  def change
    create_table :airlines do |t|
      t.string		:name
      t.string		:alias
      t.string		:status
      t.timestamps
    end
  end
end
