class CreateAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :airports do |t|
      t.string 	:name
      t.string 	:city
      t.string	:country
      t.decimal	:lat
      t.decimal :lng
      t.decimal	:alt
      t.decimal	:timezone

      t.timestamps
    end
  end
end
