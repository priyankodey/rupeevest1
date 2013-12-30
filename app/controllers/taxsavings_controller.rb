
class TaxsavingsController < ApplicationController
	def new
		
		@taxsaving = Taxsaving.new
	end

	def create
		  
		  @taxsaving = Taxsaving.new(taxsaving_params)
		  if @taxsaving.save
		  	send_file("#{Rails.root}/app/assets/data/Tax Savings Funds.xlsx",
              filename: "Tax Savings Funds.xlsx",
              type: "pplication/vnd.ms-excel")
		  	
		  else
	      render :action => 'new'
	  	  end
	end







	private
	  def taxsaving_params
	    params.require(:taxsaving).permit(:name,:phone_number,:email)
	    

	  end







end

