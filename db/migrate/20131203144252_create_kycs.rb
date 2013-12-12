class CreateKycs < ActiveRecord::Migration
  def change
    create_table :kycs do |t|

      t.belongs_to :user	
	  t.string :first_name
	  t.string :last_name
	  t.string :father_spouse_name
	  t.string :gender
	  t.string :marital_status
	  t.date :date_of_birth
	  t.string :nationality
	  t.string :residence_status
	  t.string :pan
	  t.string :proof_of_identity
	  t.text :correspondence_address
	  t.string :correspondence_city_town_village
	  t.string :correspondence_state
	  t.string :correspondence_country
	  t.string :correspondence_postal_code
	  t.string :correspondence_landline
	  t.string :correspondence_mobile
	  t.string :correspondence_email
	  t.string :correspondence_proof_of_address
	  t.boolean :same
	  t.text :permanent_address
	  t.string :permanent_city_town_village
	  t.string :permanent_state
	  t.string :permanent_country
	  t.string :permanent_postal_code
	  t.string :permanent_landline
	  t.string :permanent_mobile
	  t.string :permanent_email
	  t.string :permanent_proof_of_address
	  t.float :annual_income
	  t.string :occupation
	  t.string :pep_status

	  t.timestamps
    end
  end
end
