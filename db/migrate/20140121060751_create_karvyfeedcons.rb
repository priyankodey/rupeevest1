class CreateKarvyfeedcons < ActiveRecord::Migration
  def change
    create_table :karvyfeedcons do |t|
    	t.string :AMC, :limit => 3
		t.string :Folio, :limit => 15
		t.string :Appl_No, :limit => 25
		t.string :Sch_Code, :limit => 4
		t.string :option, :limit => 1
		t.string :Sch_desc, :limit => 200
		t.string :Inv_name, :limit => 40
		t.string :Jt1_Hld, :limit => 40
		t.string :Jt2_Hld, :limit => 40
		t.string :Add1, :limit => 40
		t.string :Add2, :limit => 40
		t.string :Add3, :limit => 40
		t.string :City, :limit => 40
		t.string :pincode, :limit => 6
		t.string :Trxn_Num, :limit => 15
		t.string :User_Cd, :limit => 10
		t.string :Usr_trno, :limit => 15
		t.string :Trn_Mode, :limit => 1
		t.string :Sub_TrTy, :limit => 2
		t.date :Tr_Date
		t.date :Pr_Date
		t.string :POP, :limit => 10
		t.string :Units, :limit => 25
		t.string :Amount, :limit => 25
		t.string :STT, :limit => 10
		t.string :TDS, :limit => 10
		t.string :Load, :limit => 10
		t.string :Tr_Type, :limit => 15
		t.string :Tr_Desc, :limit => 40
		t.string :NAV, :limit => 10
		t.string :Br_code, :limit => 10
		t.string :Sub_code, :limit => 25
		t.string :Red_Mode, :limit => 10
		t.string :Bnk_Name, :limit => 40
		t.string :Bnk_acno, :limit => 40
		t.string :Bnk_acty, :limit => 10
		t.string :Bnk_Brn, :limit => 40
		t.string :Bnk_city, :limit => 40
		t.string :MOH, :limit => 2
		t.string :Tax_Stat, :limit => 2
		t.string :Category, :limit => 2
		t.string :BRN_Code, :limit => 5
		t.string :IH_No, :limit => 15
		t.date :Rep_Date
		t.float :Tranfee


      t.timestamps
    end
  end
end
