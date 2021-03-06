class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :banks
  has_many :transactions
  has_many :holdings
  has_one :kyc
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  
def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(first_name: data["name"],
             email: data["email"],
             password: Devise.friendly_token[0,20]
            )
    end
    user
end

end
