class AnalysesController < ApplicationController
	
	require 'finance'
	
	def create
		  @analysis = Analysis.new(analysis_params)
		  @analysis.save
		  redirect_to @analysis
	end

	def show
		@visitor = Visitor.new
		@analysis = Analysis.find(params[:id])
		


	end





	private
	  def analysis_params
	    params.require(:analysis).permit(:type,:name,:goalamount,:timeperiod,:initialamount,:periodicamount,:periodicity,:yield,:creditrating,:generalrisk,:tenuregovt,:tenurefixed)
	    

	  end



end
