class CreateMsgfrompgs < ActiveRecord::Migration
  def change
    create_table :msgfrompgs do |t|
      t.integer :user_id
      t.string :order_number
      t.float :amount
      t.text :msgpg	
      t.string :auth_status
      t.string :error
      t.timestamps
    end
  end
end
