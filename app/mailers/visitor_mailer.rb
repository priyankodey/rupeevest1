class VisitorMailer < ActionMailer::Base
  default :from => "info@rupeevest.com"
  
  def welcome(visitor)
    @visitor = visitor
    mail(:to => visitor.email, :subject => "Welcome to Rupeevest")
  end
end
