class ChangeFunds < ActiveRecord::Migration
  change_table :funds do |t|
  	  
	  t.string :amc
	  t.string :amc_code
	  t.string :amfi_code
	  t.string :scheme_code_pg
	  t.string :prodcode
	  t.string :fund_type
	  t.rename :growth_nav, :nav
  end
end
