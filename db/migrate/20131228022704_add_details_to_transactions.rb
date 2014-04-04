class AddDetailsToTransactions < ActiveRecord::Migration
   def change
    add_column :transactions, :t_date, :date
    add_column :transactions, :sip_months, :integer
    add_column :transactions, :rta, :string
    add_column :transactions, :dividend_option, :string
  end
end
