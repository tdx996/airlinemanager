class AddUserFields < ActiveRecord::Migration[5.2]
  def change
  	add_reference :users, :airline, index: true
  end
end
