class ChangeKycs < ActiveRecord::Migration
  def change
  	remove_column :kycs, :correspondence_address, :text
  	remove_column :kycs, :permanent_address, :text
  	add_column :kycs, :c_house_no, :string
    add_column :kycs, :c_street_name, :string
    add_column :kycs, :c_area_name, :string	
    add_column :kycs, :p_house_no, :string
    add_column :kycs, :p_street_name, :string
    add_column :kycs, :p_area_name, :string
  end
  
end
