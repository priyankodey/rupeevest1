class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :kyc_status, :integer
    add_column :users, :bank_status, :integer
  end
end
