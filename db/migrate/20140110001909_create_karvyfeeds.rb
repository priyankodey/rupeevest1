class CreateKarvyfeeds < ActiveRecord::Migration
  def change
    create_table :karvyfeeds do |t|

    	t.integer :user_id
        t.integer :transaction_id
        t.string :transaction_status
        t.string :feed_status
        t.string  :AMC_CODE	, :limit => 3
		t.string :BROKE_CD , :limit => 20
		t.string :SBBR_CODE, :limit => 15
		t.string :User_Code, :limit => 10
		t.integer :USR_TXN_NO, :limit => 8
		t.string :Appl_No, :limit => 10
		t.string :FOLIO_NO, :limit => 15
		t.string :Ck_DIG_NO, :limit => 10
		t.string :TRXN_TYPE, :limit => 7
		t.string :SCH_CODE, :limit => 5
		t.string :FIRST_NAME, :limit => 70
		t.string :JONT_NAME1, :limit => 35
		t.string :JONT_NAME2, :limit => 35
		t.string :ADD1, :limit => 40
		t.string :ADD2, :limit => 40
		t.string :ADD3, :limit => 40
		t.string :CITY, :limit => 35
		t.string :PINCODE, :limit => 15
		t.string :PHONE_OFF, :limit => 15
		t.string :MOBILE_NO, :limit => 15
		t.date :TRXN_DATE	
		t.time :TRXN_TIME
		t.float :UNITS
		t.float :AMOUNT
		t.string :CLOS_AC_CH, :limit => 1
		t.date :DOB		
		t.string :GUARDIAN, :limit => 35
		t.string :TAX_NUMBER, :limit => 40
		t.string :PHONE_RES, :limit => 15
		t.string :FAX_OFF, :limit => 15
		t.string :FAX_RES, :limit => 15
		t.string :EMAIL, :limit => 50
		t.string :ACCT_NO, :limit => 40
		t.string :ACCT_TYPE, :limit => 5
		t.string :BANK_NAME, :limit => 40
		t.string :BR_NAME, :limit => 40
		t.string :BANK_CITY, :limit => 35
		t.string :REINV_TAG, :limit => 1
		t.string :HOLD_NATUR, :limit => 2
		t.string :OCC_CODE, :limit => 2
		t.string :TAX_STATUS, :limit => 2
		t.string :REMARKS, :limit => 250
		t.string :STATE, :limit => 2
		t.string :PAN_2_HLDR, :limit => 40
		t.string :PAN_3_HLDR, :limit => 40
		t.string :Guard_PAN, :limit => 40
		t.string :LOCATION, :limit => 10
		t.string :UINno, :limit => 10
		t.string :FORM6061, :limit => 1
		t.string :FORM6061J1, :limit => 1
		t.string :FORM6061J2, :limit => 1
		t.string :PAY_MEC, :limit => 1
		t.string :RTGS_CD, :limit => 11
		t.string :NEFT_CD, :limit => 11
		t.string :MICR_CD, :limit => 9
		t.string :DEPBANK, :limit => 40
		t.string :DEP_ACNO, :limit => 50
		t.date :DEP_DATE	
		t.string :DEP_RFNo, :limit => 25
		t.string :SUB_TRXN_T, :limit => 6
		t.string :SIP_RFNO, :limit => 8
		t.date :SIP_RGDT	
		t.string :NOM_NAME, :limit => 40
		t.string :NOM_RELA, :limit => 40
		t.string :KYC_FLG, :limit => 1
		t.string :POA_STAT, :limit => 1
		t.string :MOD_TRXN, :limit => 1
		t.string :SIGN_VF, :limit => 1
		t.string :CUST_ID, :limit => 12
		t.string :LOG_WT, :limit => 70
		t.string :LOG_PE, :limit => 70
		t.string :DPID, :limit => 25
		t.string :ClientID, :limit => 25
		t.string :NRI_SOF, :limit => 25
		t.string :EUIN, :limit => 16
		t.string :EUIN_OPT, :limit => 1



      t.timestamps
    end
  end
end
