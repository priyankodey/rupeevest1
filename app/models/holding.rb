class Holding < ActiveRecord::Base
	belongs_to :user
	belongs_to :fund
	belongs_to :transaction
end
