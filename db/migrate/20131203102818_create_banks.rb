class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|

      t.belongs_to :user
      t.string :name_of_bank
	  t.string :bank_account_num
	  t.string :bank_account_type
	  t.string :bank_mode_of_holding
	  t.string :bank_first_holder
	  t.string :bank_second_holder
	  t.string :bank_branch_address
	  t.string :bank_city
	  t.string :bank_ifsc_code
	  t.string :bank_micr_code
	  t.integer :bank_sip_mandate_status
	  t.integer :bank_sip_year
	  t.integer :bank_sip_mandate	
      t.timestamps
    end
  end
end
