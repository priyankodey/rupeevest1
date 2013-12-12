class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|

      t.belongs_to :user
      t.belongs_to :bank
      t.belongs_to :fund
      t.string :option 
      t.string :transaction_type
      t.float :amount 
      t.float :price_per_unit
      t.string :transaction_status
      t.string :folio_id
      t.timestamps
    end
  end
end
