class RemoveIntegerFromFunds < ActiveRecord::Migration
  def change
    remove_column :funds, :integer, :string
  end
end
