class AddDetailsToTransactions < ActiveRecord::Migration
   def change
    add_column :transactions, :t_date, :date
    add_column :transactions, :sip_months, :integer
  end
end
