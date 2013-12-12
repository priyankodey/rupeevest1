class Transaction < ActiveRecord::Base
	belongs_to :user
	belongs_to :bank
	belongs_to :fund
	has_one :holding
end
