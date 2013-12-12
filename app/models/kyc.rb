class Kyc < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :father_spouse_name
	validates_presence_of :nationality
	validates_presence_of :pan
	validates_format_of :pan, :with => /\A([A-Za-z]{5}\d{4}[A-Za-z]{1})\Z/i 
	validates_presence_of :correspondence_address
	validates_presence_of :correspondence_city_town_village
	validates_presence_of :correspondence_state
	validates_presence_of :correspondence_postal_code
	validates_presence_of :correspondence_email
	validates_presence_of :permanent_address
	validates_presence_of :permanent_city_town_village
	validates_presence_of :permanent_state
	validates_presence_of :permanent_postal_code
	validates_presence_of :permanent_email
	validates_format_of :permanent_postal_code, :with => /\A(\d{6})\Z/i 
	validate :permanent_landline_or_mobile
	validates_format_of :permanent_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i 
	
	validates_format_of :correspondence_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i 
	validates_format_of :correspondence_postal_code, :with => /\A(\d{6})\Z/i 
	validate :correspondence_landline_or_mobile
	def correspondence_landline_or_mobile
	  if [self.correspondence_landline, self.correspondence_mobile].reject(&:blank?).size == 0
	    errors[:base] << ("Please fill either landline no. or mobile no.")
	  end
	end 
	def permanent_landline_or_mobile
	  if [self.permanent_landline, self.permanent_landline].reject(&:blank?).size == 0
	    errors[:base] << ("Please fill either landline no. or mobile no.")
	  end
	end 

end
