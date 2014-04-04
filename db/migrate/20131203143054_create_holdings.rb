class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|

      t.belongs_to :user
      t.belongs_to :fund
      t.belongs_to :transaction
      t.integer :units 
      t.float :buy_value
      t.float :current_value
      t.string :folio
      t.string :amc_code											
	  t.timestamps
    end
  end
end
