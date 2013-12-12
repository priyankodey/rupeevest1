class FundsController < ApplicationController


def index
	@visitor = Visitor.new
 	@funds = Fund.all

end


def show
	@visitor = Visitor.new
	@fund = Fund.find(params[:id])
	
end




end
