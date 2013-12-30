class ChangeBanks < ActiveRecord::Migration
    change_table :banks do |t|
  	
	  t.string :umrn
	  t.string :reason
	  t.string :bankid_pg
  end
end
