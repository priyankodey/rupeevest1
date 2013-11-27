class FreekycMailer < ActionMailer::Base
   default :from => "info@rupeevest.com"
  
  def welcome(freekyc)
    @freekyc = freekyc
    mail(:to => freekyc.email, :subject => "Free KYC service registration")
  end
end
