class TransactionsController < ApplicationController
	
helper_method :createholdings

 def create_multiple
    params[:transactions].each do |transaction1|
     transaction = current_user.transactions.build(transaction1)
     transaction.bank_id = params[:bankid]
     transaction.arn_code = "ARN-86572"
     f = Fund.find_by_id(transaction.fund_id)
     if f.category == "Debt: Liquid"
        transaction.liq_non = "LIQUID"
     else
        transaction.liq_non = "NONLIQUID"
     end

     transaction.save
     transaction.order_number = transaction.ord_num
     
    end
    @transactions2 = current_user.transactions.find(:all ,:conditions => ["transaction_status = 'PrePayement'"])

    @ordernum = @transactions2.first.ord_num 
    @transactions2.each do |transaction|
      transaction.order_number = @ordernum
      transaction.save
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

end


