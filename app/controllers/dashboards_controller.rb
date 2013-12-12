class DashboardsController < ApplicationController
	

	def investment
		@funds = Fund.find(params[:fund_ids])
		
	end
	def show
	end
	



end
