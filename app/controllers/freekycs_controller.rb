class FreekycsController < ApplicationController
	def new
		@visitor = Visitor.new
		@freekyc = Freekyc.new
	end

	def create
		  @visitor = Visitor.new
		  @freekyc = Freekyc.new(freekyc_params)
		  if @freekyc.save
		  	FreekycMailer.welcome(@freekyc).deliver
		  	redirect_to static_pages_home_path
		  else
	      render :action => 'new'
	  	  end
	end

	





	private
	  def freekyc_params
	    params.require(:freekyc).permit(:name,:phone_number,:address,:email,:pan)
	    

	  end







end

