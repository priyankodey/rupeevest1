class Freekyc < ActiveRecord::Base

	validates_presence_of :name
	validates_presence_of :phone_number
	validates_presence_of :email
	validates_presence_of :pan
	validates_format_of :pan, :with => /\A([A-Za-z]{5}\d{4}[A-Za-z]{1})\Z/i 
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i 
end
