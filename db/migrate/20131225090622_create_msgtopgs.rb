class CreateMsgtopgs < ActiveRecord::Migration
  def change
    create_table :msgtopgs do |t|
      t.integer :user_id
      t.string :order_number
      t.float :amount
      t.text :msg
      t.timestamps
    end
  end
end
