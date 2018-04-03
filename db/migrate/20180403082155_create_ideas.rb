class CreateIdeas < ActiveRecord::Migration[5.1]
  def change
  	create_table :ideas do |t|
  		t.string :keimeno
  		t.integer :user_id
  	end
  end
end
