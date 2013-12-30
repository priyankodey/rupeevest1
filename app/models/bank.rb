class Bank < ActiveRecord::Base
	belongs_to :user
	has_many :transactions

	validates_presence_of :name_of_bank ,:bank_account_num , :bank_account_type ,:bank_mode_of_holding,
	 :bank_first_holder,:bank_branch_address, :bank_city, :bank_ifsc_code, :bank_micr_code

  def umrn_no
    "URMN-%.8d" % id
  end
end
