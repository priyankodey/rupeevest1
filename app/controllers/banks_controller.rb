class BanksController < ApplicationController
	

	def new 
  	@bank = current_user.banks.build
	end


	
	def create
	    
	    @bank = current_user.banks.build(bank_params)
	    @bank.user_id = current_user.id
	  
		if @bank.save
	      current_user.bank_status = 1
	      current_user.save
	      redirect_to dashboard_show_path
	    else
	      render :action => 'new'
	    end
	      
  	end


  	def edit
    	@bank = Bank.find(params[:id])
  	end
  
    def update
	    @bank = Bank.find(params[:id])
	    if @bank.update_attributes(bank_params)
	      
	      redirect_to dashboard_show_path
	    else
	      render :action => 'edit'
	    end
	 end
		

  private
	  def bank_params
	    params.require(:bank).permit(:name_of_bank ,:bank_account_num , :bank_account_type ,:bank_mode_of_holding,
	 :bank_first_holder,:bank_branch_address, :bank_city, :bank_ifsc_code, :bank_micr_code,:bank_second_holder,
	  :bank_sip_mandate_status, :bank_sip_year, :bank_sip_mandate)
	    

	  end



end
