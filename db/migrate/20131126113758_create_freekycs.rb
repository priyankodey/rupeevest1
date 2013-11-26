class CreateFreekycs < ActiveRecord::Migration
  def change
    create_table :freekycs do |t|
    	t.string :name
    	t.string :email
    	t.text :address
    	t.string :phone_number
    	t.string :pan

      t.timestamps
    end
  end
end
