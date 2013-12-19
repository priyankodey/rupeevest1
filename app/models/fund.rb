class Fund < ActiveRecord::Base
	has_many :transactions
	has_many :holdings


end
