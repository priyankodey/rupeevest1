class KycsController < ApplicationController

	def new
	 
	  if current_user.kyc_status != 1
	  	@kyc = current_user.build_kyc	
	  else
	  	 @kyc = current_user.kyc
	  end

	end


	
	def create
	    
	    @kyc = current_user.build_kyc(kyc_params)
	    @kyc.user_id = current_user.id
	    if @kyc.same == true
	    	@kyc.permanent_address = @kyc.correspondence_address
	    	@kyc.permanent_state = @kyc.correspondence_state
	    	@kyc.permanent_city_town_village = @kyc.correspondence_city_town_village
	    	@kyc.permanent_country =@kyc.correspondence_country
	    	@kyc.permanent_landline = @kyc.correspondence_landline
	    	@kyc.permanent_mobile = @kyc.correspondence_mobile
	    	@kyc.permanent_email = @kyc.correspondence_email
	    	@kyc.permanent_postal_code = @kyc.correspondence_postal_code
	    end	
		if @kyc.save
	      current_user.kyc_status = 1
	      current_user.save
	      redirect_to dashboard_show_path
	    else
	      render :action => 'new'
	    end
	      
  	end
		
  	def update
       @kyc = current_user.kyc
       @kyc.update_attributes(kyc_params)
       redirect_to dashboard_show_path  
   end

  private
	  def kyc_params
	    params.require(:kyc).permit(:first_name,:last_name,:father_spouse_name,:gender,:marital_status,:date_of_birth,
	     :nationality,:residence_status, :pan, :proof_of_identity, :correspondence_address,:correspondence_city_town_village,
	     :correspondence_state, :correspondence_country,:correspondence_postal_code,:correspondence_landline,
	     :correspondence_mobile,:correspondence_email, :correspondence_proof_of_address,:same,:permanent_address,
	     :permanent_city_town_village,:permanent_state,:permanent_country, :permanent_postal_code, :permanent_landline,
	     :permanent_mobile, :permanent_email, :permanent_proof_of_address,:annual_income, :occupation, :pep_status)
	    

	  end

end
