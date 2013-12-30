class ChangeTransactions < ActiveRecord::Migration
    change_table :transactions do |t|
  	  
	  t.string :billdesk_trnx_no
	  t.string :transaction_status_reason
	  t.string :order_number
	  t.string :checksum
	  t.string :liq_non
	  t.string :error_status
	  t.string :error_desc
	  t.string :auth_status
	  t.float :transaction_charges
	  t.string :arn_code
	  
	  
  end
end
