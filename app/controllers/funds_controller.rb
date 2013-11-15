class FundsController < ApplicationController


def index
	@visitor = Visitor.new
 	@funds = Fund.all
end



end
