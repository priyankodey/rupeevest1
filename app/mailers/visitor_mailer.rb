class VisitorMailer < ActionMailer::Base
  default :from => "varun11us@gmail.com"
  
  def welcome(visitor)
    @visitor = visitor
    mail(:to => visitor.email, :subject => "Welcome to Rupeevest")
  end
end
