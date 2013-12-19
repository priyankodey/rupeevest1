class TransactionsController < ApplicationController
	
helper_method :createholdings

 def create_multiple
    params[:transactions].each do |transaction1|
     transaction = current_user.transactions.build(transaction1)
     transaction.bank_id = params[:bankid]
     transaction.save
    end
    redirect_to action: 's'
  end

  def s
  	@transactions1 = current_user.transactions.find(:all ,:conditions => ["transaction_status = 'PrePayement'"])
  	@funds = Fund.all
  	@total = 0
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

end
