class TransactionsController < ApplicationController
	
helper_method :createholdings

 def create_multiple
    params[:transactions].each do |transaction1|
     transaction = current_user.transactions.build(transaction1)

     transaction.bank_id = params[:bankid]
     transaction.arn_code = "ARN-86572"
     f = Fund.find_by_id(transaction.fund_id)
     if f.amc_code == "A" || "BP"
      transaction.rta = "Karvy"
     end
     if f.amc_code == "BS"
      transaction.rta = "Cams"
     end
     if f.category == "Debt: Liquid"
        transaction.liq_non = "LIQUID"
     else
        transaction.liq_non = "NONLIQUID"
     end



     transaction.save
     transaction.order_number = transaction.ord_num
     
    end
    transactions2 = current_user.transactions.find(:all ,:conditions => ["transaction_status = 'PrePayement'"])

    ordernum = transactions2.first.ord_num 
    transactions2.each do |transaction|
      transaction.order_number = ordernum
      transaction.save
    end


    #make feed for karvy 
    transactions_karvy = current_user.transactions.find(:all ,:conditions => ["transaction_status = 'PrePayement' AND rta = 'Karvy'"])
    
    #make feed for lumpsum
    if transactions_karvy!= nil
      transactions_karvy_lumpsum = current_user.transactions.find(:all ,:conditions => ["transaction_status = 'PrePayement' AND rta = 'Karvy' AND transaction_type = 'Lumpsum'"])
    end
    if transactions_karvy_lumpsum!= nil
      transactions_karvy_lumpsum.each do |t|
          karvyfund = Fund.find_by_id(t.fund_id)
          karvybank = Bank.find_by_id(t.bank_id)
          karvykyc = Kyc.find_by_id(t.user_id)
          karvyfeed = Karvyfeed.new
          karvyfeed.user_id = current_user.id
          karvyfeed.transaction_id = t.id
          karvyfeed.transaction_status = 'PrePayement'
          karvyfeed.feed_status = 'Initiated'
          karvyfeed.AMC_CODE = karvyfund.amc_code
          karvyfeed.BROKE_CD = t.arn_code
          #karvyfeed.SBBR_CODE
          karvyfeed.User_Code = t.user_id #check logic for this again
          karvyfeed.USR_TXN_NO = t.order_number # change format to all digits
          #karvyfeed.Appl_No
          if t.folio_id == 'New'
            karvyfeed.FOLIO_NO = ''
          else
            karvyfeed.FOLIO_NO = t.folio_id
          end
          #karvyfeed.Ck_DIG_NO NA

          karvyfeed.TRXN_TYPE = 'P'
          karvyfeed.SCH_CODE= karvyfund.scheme_code_pg #check if karvy and pg scheme codes are same
          karvyfeed.FIRST_NAME = karvykyc.first_name
          if karvybank.bank_mode_of_holding == 'Joint'
            karvyfeed.JONT_NAME1 = karvybank.bank_first_holder
            karvyfeed.JONT_NAME2 = karvybank.bank_second_holder
          end
          karvyfeed.ADD1= karvykyc.p_house_no 
          karvyfeed.ADD2= karvykyc.p_street_name
          karvyfeed.ADD3= karvykyc.p_area_name
          karvyfeed.CITY= karvykyc.permanent_city_town_village
          karvyfeed.PINCODE= karvykyc.permanent_postal_code
          karvyfeed.PHONE_OFF= karvykyc.permanent_landline
          karvyfeed.MOBILE_NO= karvykyc.permanent_mobile
          karvyfeed.TRXN_DATE = t.created_at.strftime('%m/%d/%Y') 
          karvyfeed.TRXN_TIME = t.created_at.strftime('%m/%d/%Y') #sort this out
          #karvyfeed.UNITS
          karvyfeed.AMOUNT = t.amount
          #karvyfeed.CLOS_AC_CH
          karvyfeed.DOB = karvykyc.date_of_birth.strftime('%m/%d/%Y')    
          karvyfeed.GUARDIAN = karvykyc.father_spouse_name #condition if minor
          karvyfeed.TAX_NUMBER = karvykyc.pan
          karvyfeed.PHONE_RES = karvykyc.permanent_landline
          #karvyfeed.FAX_OFF
          #karvyfeed.FAX_RES
          karvyfeed.EMAIL = karvykyc.permanent_mobile
          karvyfeed.ACCT_NO = karvybank.bank_account_num
          karvyfeed.ACCT_TYPE = karvybank.bank_account_type
          karvyfeed.BANK_NAME = karvybank.name_of_bank
          karvyfeed.BR_NAME = karvybank.bank_branch_address
          karvyfeed.BANK_CITY = karvybank.bank_city
          if t.dividend_option == "Reinvest"
            karvyfeed.REINV_TAG = 'Y'
          elsif t.dividend_option == "Payout"
            karvyfeed.REINV_TAG = 'N'
          else
            karvyfeed.REINV_TAG = 'Z'
          end
          if karvybank.bank_mode_of_holding == "Single"
            karvyfeed.HOLD_NATUR = "SI"
          end
          if karvybank.bank_mode_of_holding == "Joint"
            karvyfeed.HOLD_NATUR = "JO"
          end
          if karvykyc.occupation == "Service"
            karvyfeed.OCC_CODE = '1'
          elsif karvykyc.occupation == "Business"
            karvyfeed.OCC_CODE = '2'
          elsif karvykyc.occupation == "Student"
            karvyfeed.OCC_CODE = '3'
          elsif karvykyc.occupation == "Household"
            karvyfeed.OCC_CODE = '4'
          elsif karvykyc.occupation == "Professional"
            karvyfeed.OCC_CODE = '5'
          elsif karvykyc.occupation == "Farmer"
            karvyfeed.OCC_CODE = '6'
          elsif karvykyc.occupation == "Retired"
          
            karvyfeed.OCC_CODE = '7'
          else
            karvyfeed.OCC_CODE = '8'
          end

          karvyfeed.TAX_STATUS = '1' #individual
          #karvyfeed.REMARKS
          if karvykyc.permanent_state =="Andhra Pradesh"
                   karvyfeed.STATE = "01"
          elsif karvykyc.permanent_state =="Arunachal Pradesh"
                   karvyfeed.STATE = "02"
          elsif karvykyc.permanent_state =="Assam"
                   karvyfeed.STATE = "03"
          elsif karvykyc.permanent_state =="Bihar"
                   karvyfeed.STATE = "04"
          elsif karvykyc.permanent_state =="Chandigarh"
                   karvyfeed.STATE = "05"
          elsif karvykyc.permanent_state =="Delhi"
                   karvyfeed.STATE = "06"
          elsif karvykyc.permanent_state =="Goa"
                   karvyfeed.STATE = "07"
          elsif karvykyc.permanent_state =="Gujarat"
                   karvyfeed.STATE = "08"
          elsif karvykyc.permanent_state =="Haryana"
                   karvyfeed.STATE = "09"
          elsif karvykyc.permanent_state =="Himachal Pradesh"
                   karvyfeed.STATE = "10"
          elsif karvykyc.permanent_state =="Jammu And Kashmir"
                   karvyfeed.STATE = "11"
          elsif karvykyc.permanent_state =="Karnataka"
                   karvyfeed.STATE = "12"
          elsif karvykyc.permanent_state =="Kerala"
                   karvyfeed.STATE = "13"
          elsif karvykyc.permanent_state =="Madhya Pradesh"
                   karvyfeed.STATE = "14"
          elsif karvykyc.permanent_state =="Maharashtra"
                   karvyfeed.STATE = "15"
          elsif karvykyc.permanent_state =="Manipur"
                   karvyfeed.STATE = "16"
          elsif karvykyc.permanent_state =="Meghalaya"
                   karvyfeed.STATE = "17"
          elsif karvykyc.permanent_state =="Mizoram"
                   karvyfeed.STATE = "18"
          elsif karvykyc.permanent_state =="Nagaland"
                   karvyfeed.STATE = "19"
          elsif karvykyc.permanent_state =="Orissa"
                   karvyfeed.STATE = "20"
          elsif karvykyc.permanent_state =="Punjab"
                   karvyfeed.STATE = "21"
          elsif karvykyc.permanent_state =="Rajasthan"
                   karvyfeed.STATE = "22"
          elsif karvykyc.permanent_state =="Tamil Nadu"
                   karvyfeed.STATE = "23"
          elsif karvykyc.permanent_state =="Tripura"
                   karvyfeed.STATE = "24"
          elsif karvykyc.permanent_state =="Uttar Pradesh"
                   karvyfeed.STATE = "25"
          elsif karvykyc.permanent_state =="West Bengal"
                   karvyfeed.STATE = "26"
          else  karvyfeed.STATE = "27"
          end
          #karvyfeed.PAN_2_HLDR, :limit => 40
          #karvyfeed.PAN_3_HLDR, :limit => 40
          #karvyfeed.Guard_PAN, :limit => 40
          if karvykyc.permanent_city_town_village =="Agra"
                   karvyfeed.LOCATION = "A1"
          elsif karvykyc.permanent_city_town_village =="Ahmedabad"
                   karvyfeed.LOCATION = "A2"
          elsif karvykyc.permanent_city_town_village =="Ajmer" 
                   karvyfeed.LOCATION = "A3"
          elsif karvykyc.permanent_city_town_village =="Allahabad" 
                   karvyfeed.LOCATION = "A4"
          elsif karvykyc.permanent_city_town_village =="Amritsar"
                   karvyfeed.LOCATION = "A5"
          elsif karvykyc.permanent_city_town_village =="Anand"
                   karvyfeed.LOCATION = "A6"
          elsif karvykyc.permanent_city_town_village =="Asansol" 
                   karvyfeed.LOCATION = "A7"
          elsif karvykyc.permanent_city_town_village =="Aurangabad"
                   karvyfeed.LOCATION = "A8"
          elsif karvykyc.permanent_city_town_village =="Bangalore"
                   karvyfeed.LOCATION = "B1"
          elsif karvykyc.permanent_city_town_village =="Baroda"
                   karvyfeed.LOCATION = "B2"
          elsif karvykyc.permanent_city_town_village =="Bharuch"
                   karvyfeed.LOCATION = "B3"
          elsif karvykyc.permanent_city_town_village =="Bhavnagar"
                   karvyfeed.LOCATION = "B4"
          elsif karvykyc.permanent_city_town_village =="Bhopal"
                   karvyfeed.LOCATION = "B5"
          elsif karvykyc.permanent_city_town_village =="Bhubaneswar"
                   karvyfeed.LOCATION = "B6"
          elsif karvykyc.permanent_city_town_village =="Calicut"
                   karvyfeed.LOCATION = "C1"
          elsif karvykyc.permanent_city_town_village =="Chandigarh"
                   karvyfeed.LOCATION = "C2"
          elsif karvykyc.permanent_city_town_village =="Chennai"
                   karvyfeed.LOCATION = "C3"
          elsif karvykyc.permanent_city_town_village =="Coimbatore"
                   karvyfeed.LOCATION = "C4"
          elsif karvykyc.permanent_city_town_village =="Dehradun"
                   karvyfeed.LOCATION = "D1"
          elsif karvykyc.permanent_city_town_village =="Dharwad"
                   karvyfeed.LOCATION = "D2"
          elsif karvykyc.permanent_city_town_village =="Dubai"
                   karvyfeed.LOCATION = "D3"
          elsif karvykyc.permanent_city_town_village =="Durgapur"
                   karvyfeed.LOCATION = "D4"
          elsif karvykyc.permanent_city_town_village =="Erode"
                   karvyfeed.LOCATION = "E1"
          elsif karvykyc.permanent_city_town_village =="Guntur"
                   karvyfeed.LOCATION = "G1"
          elsif karvykyc.permanent_city_town_village =="Guwahati"
                   karvyfeed.LOCATION = "G2"
          elsif karvykyc.permanent_city_town_village =="Hubli"
                   karvyfeed.LOCATION = "H1"
          elsif karvykyc.permanent_city_town_village =="Hyderabad"
                   karvyfeed.LOCATION = "H2"
          elsif karvykyc.permanent_city_town_village =="Indore"
                   karvyfeed.LOCATION = "I1"
          elsif karvykyc.permanent_city_town_village =="Jaipur"
                   karvyfeed.LOCATION = "J1"
          elsif karvykyc.permanent_city_town_village =="Jalandhar"
                   karvyfeed.LOCATION = "J2"
          elsif karvykyc.permanent_city_town_village =="Jalgaon"
                   karvyfeed.LOCATION = "J3"
          elsif karvykyc.permanent_city_town_village =="Jamnagar"
                   karvyfeed.LOCATION = "J4"
          elsif karvykyc.permanent_city_town_village =="Jamshedpur"
                   karvyfeed.LOCATION = "J5"
          elsif karvykyc.permanent_city_town_village =="Jodpur"
                   karvyfeed.LOCATION = "J6"
          elsif karvykyc.permanent_city_town_village =="Kanpur"
                   karvyfeed.LOCATION = "K1"
          elsif karvykyc.permanent_city_town_village =="Karaikudi"
                   karvyfeed.LOCATION = "K2"
          elsif karvykyc.permanent_city_town_village =="Kochi"
                   karvyfeed.LOCATION = "K3"
          elsif karvykyc.permanent_city_town_village =="Kolkata"
                   karvyfeed.LOCATION = "K4"
          elsif karvykyc.permanent_city_town_village =="Kota"
                   karvyfeed.LOCATION = "K5"
          elsif karvykyc.permanent_city_town_village =="Kottayam"
                   karvyfeed.LOCATION = "K6"
          elsif karvykyc.permanent_city_town_village =="Lucknow"
                   karvyfeed.LOCATION = "L1"
          elsif karvykyc.permanent_city_town_village =="Ludhiana"
                   karvyfeed.LOCATION = "L2"
          elsif karvykyc.permanent_city_town_village =="Mangalore"
                   karvyfeed.LOCATION = "M1"
          elsif karvykyc.permanent_city_town_village =="Meerut"
                   karvyfeed.LOCATION = "M2"
          elsif karvykyc.permanent_city_town_village =="Moradabad"
                   karvyfeed.LOCATION = "M3"
          elsif karvykyc.permanent_city_town_village =="Mumbai"
                   karvyfeed.LOCATION = "M4"
          elsif karvykyc.permanent_city_town_village =="Mysore"
                   karvyfeed.LOCATION = "M5"
          elsif karvykyc.permanent_city_town_village =="Nagpur"
                   karvyfeed.LOCATION = "N1"
          elsif karvykyc.permanent_city_town_village =="Nasik"
                   karvyfeed.LOCATION = "N2"
          elsif karvykyc.permanent_city_town_village =="New Delhi"
                   karvyfeed.LOCATION = "N3"
          elsif karvykyc.permanent_city_town_village =="Panjim"
                   karvyfeed.LOCATION = "P1"
          elsif karvykyc.permanent_city_town_village =="Patna"
                   karvyfeed.LOCATION = "P2"
          elsif karvykyc.permanent_city_town_village =="Pondicherry"
                   karvyfeed.LOCATION = "P3"
          elsif karvykyc.permanent_city_town_village =="Pune"
                   karvyfeed.LOCATION = "P4"
          elsif karvykyc.permanent_city_town_village =="Raipur"
                   karvyfeed.LOCATION = "R1"
          elsif karvykyc.permanent_city_town_village =="Rajahmundry"
                   karvyfeed.LOCATION = "R2"
          elsif karvykyc.permanent_city_town_village =="Rajkot"
                   karvyfeed.LOCATION = "R3"
          elsif karvykyc.permanent_city_town_village =="Ranchi"
                   karvyfeed.LOCATION = "R4"
          elsif karvykyc.permanent_city_town_village =="Salem"
                   karvyfeed.LOCATION = "S1"
          elsif karvykyc.permanent_city_town_village =="Siliguri"
                   karvyfeed.LOCATION = "S2"
          elsif karvykyc.permanent_city_town_village =="Surat"
                   karvyfeed.LOCATION = "S3"
          elsif karvykyc.permanent_city_town_village =="Tirunelveli"
                   karvyfeed.LOCATION = "T1"
          elsif karvykyc.permanent_city_town_village =="Tirupur"
                   karvyfeed.LOCATION = "T2"
          elsif karvykyc.permanent_city_town_village =="Trichy"
                   karvyfeed.LOCATION = "T3"
          elsif karvykyc.permanent_city_town_village =="Trivandrum"
                   karvyfeed.LOCATION = "T4"
          elsif karvykyc.permanent_city_town_village =="Udaipur"
                   karvyfeed.LOCATION = "U1"
          elsif karvykyc.permanent_city_town_village =="Varanasi"
                   karvyfeed.LOCATION = "V1"
          elsif karvykyc.permanent_city_town_village =="Vashi"
                   karvyfeed.LOCATION = "V2"
          elsif karvykyc.permanent_city_town_village =="Vijayawada"
                   karvyfeed.LOCATION = "V3"
          else karvyfeed.LOCATION = "O1"
          end

          #karvyfeed.UINno, :limit => 10


          #karvyfeed.FORM6061, :limit => 1
          #karvyfeed.FORM6061J1, :limit => 1
          #karvyfeed.FORM6061J2, :limit => 1
          karvyfeed.PAY_MEC = "D"
         # karvyfeed.RTGS_CD, :limit => 11
          #karvyfeed.NEFT_CD, :limit => 11
          #karvyfeed.MICR_CD, :limit => 9
          #karvyfeed.DEPBANK, :limit => 40
          #karvyfeed.DEP_ACNO, :limit => 50
          #karvyfeed.DEP_DATE  
          #karvyfeed.DEP_RFNo, :limit => 25
          karvyfeed.SUB_TRXN_T = "Normal"
          #karvyfeed.SIP_RFNO, :limit => 8
          #karvyfeed.SIP_RGDT  
          #karvyfeed.NOM_NAME
          #karvyfeed.NOM_RELA
          karvyfeed.KYC_FLG = "Y"
          karvyfeed.POA_STAT = "N" # cheeck
          karvyfeed.MOD_TRXN = "W"
          karvyfeed.SIGN_VF = "Y"
          #karvyfeed.CUST_ID, :limit => 12 check
          #karvyfeed.LOG_WT, :limit => 70
          #karvyfeed.LOG_PE, :limit => 70 yes
          #karvyfeed.DPID, :limit => 25
          #karvyfeed.ClientID, :limit => 25
          #

          #karvyfeed.NRI_SOF
          karvyfeed.EUIN = "E071888"
          karvyfeed.EUIN_OPT = "Y"
          karvyfeed.save

      end

    end




    redirect_to action: 's'
  end

  def s
  	@transactions1 = current_user.transactions.find(:all ,:conditions => ["transaction_status = 'PrePayement'"])
  	@funds = Fund.all
    msgtopg  = Msgtopg.new
    @msgsip = []
    @total = 0
    i=0
    additional_info5a = ['NA','NA','NA','NA']
    additional_info9a = ['NA','NA','NA','NA']
    additional_info8a = ['NA','NA','NA','NA']
    @transactions1.each do |t|
      @total = t.amount + @total
      additional_info5a[i] = Fund.find_by_id(t.fund_id).amc_code
      additional_info9a[i] = Fund.find_by_id(t.fund_id).scheme_code_pg
      additional_info8a[i] = t.amount
      i= i+1
    end
  	msgtopg.amount = @total
    msgtopg.user_id = current_user.id
    additional_info1= @transactions1.first.order_number
    msgtopg.order_number = additional_info1
    txtMerchantUserRefNo = Bank.find_by_id( @transactions1.first.bank_id).bank_account_num
    txtBankID = Bank.find_by_id( @transactions1.first.bank_id).bankid_pg
    additional_info2 = 'NA' # folio logic here
    additional_info3 = current_user.id # change id logic
    additional_info4 = 'ARN-86572'
    additional_info5 = "#{additional_info5a[0]}-#{additional_info5a[1]}-#{additional_info5a[2]}-#{additional_info5a[3]}"
    additional_info6 = @transactions1.first.liq_non # check if only liq in one sector
    additional_info7 = Bank.find_by_id( @transactions1.first.bank_id).bank_account_type
    if additional_info7 == 'Savings' || 'Current'
      additional_info7 = 'RESIDENT'
    end
    additional_info9 = "#{additional_info9a[0]}-#{additional_info9a[1]}-#{additional_info9a[2]}-#{additional_info9a[3]}" 
    additional_info10 = 'NA' #logic for sender SIP No.
    additional_info11 =  'L' # build logic for SIP
    additional_info12 = 'NA' # clarify this
    additional_info7to12 = "#{additional_info7}-#{additional_info9}-#{additional_info10}-#{additional_info11}-#{additional_info12}-rupeevest"
    # check date time format and amount format
    additional_info8 = "#{DateTime.now.to_date}-#{additional_info8a[0]}-#{additional_info8a[1]}-#{additional_info8a[2]}-#{additional_info8a[3]}"
    @msg = "RUPEEVEST|#{additional_info1}|#{txtMerchantUserRefNo}|#{@total}|#{txtBankID}|NA|NA|INR|DIRECT|R|rupeevest|NA|NA|F|#{additional_info2}|#{additional_info3}|#{additional_info4}|#{additional_info5}|#{additional_info6}|#{additional_info7to12}|#{additional_info8}|http://rupeevest.com/transactions/ru|checksum"
    #fix checksum and RU
    msgtopg.msg = @msg
    msgtopg.save
    if @transactions1.first.transaction_type == 'SIP'
      @transactions1.each do |t|

        str = "#{t.order_number},#{Bank.find_by_id(t.bank_id).umrn},#{current_user.first_name},#{t.arn_code},#{Fund.find_by_id(t.fund_id).amc_code},#{Fund.find_by_id(t.fund_id).scheme_name},#{Fund.find_by_id(t.fund_id).scheme_code_pg},NA,#{t.t_date.to_s.delete('-')},#{t.amount}"
        @msgsip << str
      end
    end

  end




  def createholdings
  		@transactions2 = current_user.transactions.find(:all ,:conditions => ["transaction_status = 'PrePayement'"])
  		@transactions2.each do |transaction|
  		@holding = current_user.holdings.build
  		@holding.transaction_id = transaction.id 
  		@holding.fund_id = transaction.fund_id
  		@holding.buy_value = transaction.amount
  		transaction.transaction_status = 'PostPayement'
  		transaction.save
  		@holding.save		
  		end
  	
  end

  def ru
      if params[:msgsip]
        
      end
  end

  def confirmation

    response = params[:msgpg].split('|')
    @r = response
    msgfrompg = Msgfrompg.new
    msgfrompg.msgpg =  params[:msgpg]
    msgfrompg.order_number =  response[2] 
    msgfrompg.amount = response[4].to_f
    msgfrompg.auth_status = response[14]
    msgfrompg.user_id = response[1]
    msgfrompg.error = response[23]
    msgfrompg.save
    user = User.find_by_id(msgfrompg.user_id)
    if user != nil
     
      transactions2 =user.transactions.where(:order_number => msgfrompg.order_number)
      msgtopg = Msgtopg.find_by_order_number(msgfrompg.order_number)
      if (transactions2 != nil) && (msgtopg != nil)
          if msgfrompg.auth_status == "0300" 
            if msgfrompg.amount == msgtopg.amount 
              transactions2 . each do |t|
                t.auth_status = msgfrompg.auth_status
                t.transaction_status = 'SUCESS'
                t.save

              end
            end
            if msgfrompg.amount != msgtopg.amount
              msgfrompg.error = "Amount does not match"
              msgfrompg.save
            end

          end
          if msgfrompg.auth_status == "0399" 
            transactions2 . each do |t|
                t.auth_status = msgfrompg.auth_status
                t.transaction_status = 'FALIURE'
                t.error_desc = "Invalid Authentication at Bank"
                t.save
            end
           
          end
          if msgfrompg.auth_status == "NA" 
            transactions2 . each do |t|
                t.auth_status = msgfrompg.auth_status
                t.transaction_status = 'FALIURE'
                t.error_desc = "Invalid Input in Request Message"
                t.save
            end
           
          end
          if msgfrompg.auth_status == "0001" 
            transactions2 . each do |t|
                t.auth_status = msgfrompg.auth_status
                t.transaction_status = 'FALIURE'
                t.error_desc = "Error at Bill Desk"
                t.save
            end
           
          end
          if msgfrompg.auth_status == "0002" 
            transactions2 . each do |t|
                t.auth_status = msgfrompg.auth_status
                t.transaction_status = 'FALIURE'
                t.error_desc = "BillDesk is waiting for Response from Bank"
                t.save
            end
           
          end
      end

     end
   if (user == nil) || (transactions2 == nil) || (msgtopg == nil)
    msgfrompg.error = "Message not processed"
    msgfrompg.save
   end

  end


  def importkarvyfeed
    require 'dbf'
    widgets = DBF::Table.new("widgets.dbf")
    widgets.each do |record|
      karvyfeed = Karvyfeed.find_by_USR_TXN_NO(record.Usr_trno)
      if karvyfeed.exists?
        transaction = Transaction.find_by_id(karvyfeed.transaction_id)
        karvyfeedcon = Karvyfeedcon.new
        karvyfeedcon.AMC = record.AMC
        karvyfeedcon.Folio= record.Folio
        karvyfeedcon.Appl_No = record.Appl_No
        karvyfeedcon.Sch_Code = record.Sch_Code
        karvyfeedcon.option = record.option
        karvyfeedcon.Sch_desc = record.Sch_desc
        karvyfeedcon.Inv_name = record.Inv_name
        karvyfeedcon.Jt1_Hld = record.Jt1_Hld
        karvyfeedcon.Jt2_Hld = record.Jt2_Hld
        karvyfeedcon.Add1 = record.Add1
        karvyfeedcon.Add2 = record.Add2
        karvyfeedcon.Add3 = record.Add3
        karvyfeedcon.City = record.City
        karvyfeedcon.pincode = record.pincode
        karvyfeedcon.Trxn_Num = record.Trxn_Num
        karvyfeedcon.User_Cd = record.User_Cd
        karvyfeedcon.Usr_trno = record.Usr_trno
        karvyfeedcon.Trn_Mode = record.Trn_Mode
        karvyfeedcon.Sub_TrTy = record.Sub_TrTy
        karvyfeedcon.Tr_Date = record.Tr_Date
        karvyfeedcon.Pr_Date = record.Pr_Date
        karvyfeedcon.POP = record.POP
        karvyfeedcon.Units = record.Units
        karvyfeedcon.Amount = record.Amount
        karvyfeedcon.STT = record.STT
        karvyfeedcon.TDS = record.TDS
        karvyfeedcon.Load = record.Load
        karvyfeedcon.Tr_Type = record.Tr_Type
        karvyfeedcon.Tr_Desc = record.Tr_Desc
        karvyfeedcon.NAV = record.NAV
        karvyfeedcon.Br_code = record.Br_code
        karvyfeedcon.Sub_code = record.Sub_code
        karvyfeedcon.Red_Mode = record.Red_Mode
        karvyfeedcon.Bnk_Name = record.Bnk_Name
        karvyfeedcon.Bnk_acno = record.Bnk_acno
        karvyfeedcon.Bnk_acty = record.Bnk_acty
        karvyfeedcon.Bnk_Brn = record.Bnk_Brn
        karvyfeedcon.Bnk_city = record.Bnk_city
        karvyfeedcon.MOH = record.MOH
        karvyfeedcon.Tax_Stat = record.Tax_Stat
        karvyfeedcon.Category = record.Category
        karvyfeedcon.BRN_Code = record.BRN_Code
        karvyfeedcon.IH_No = record.IH_No
        karvyfeedcon.Rep_Date = record.Rep_Date
        karvyfeedcon.Tranfee = record.Tranfee
        karvyfeedcon.save
      end
    end
    
    



    
  end

end


