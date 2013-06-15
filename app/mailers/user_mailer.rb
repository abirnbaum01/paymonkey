class UserMailer < ActionMailer::Base
  default from: "no-reply@example.com", return_path: "returnpath@example.com"

  def welcome_email(payment, current_user)
  	@current_user = current_user
    @payment = payment

    if User.find_by_email(@payment.email).email == nil
      @url = payments_url(:auth_token => User.find_by_email(@payment.email).authentication_token)
    else
      @url = payments_url
    end 

    mail(:to => @payment.email, :subject => "Yo, you owe some money!", :cc => User.find(@payment.user_id).email)
  end
  
  #this will send separate emails to each payee in the database, across all users
  def reminder_email(payment)
    @payment = payment
        
    if User.find_by_email(@payment.email).email == nil
      @url = payments_url(:auth_token => User.find_by_email(@payment.email).authentication_token)
    else
      @url = payments_url
    end 

    mail(:to => @payment.email, :subject => "Reminder that you owe some money", :cc => User.find(@payment.user_id).email)
  end

  #this will send one email with all payments to each payee, from a particular user
  def reminder_email2(all_payments)
    @all_payments = all_payments
        
    if User.find_by_email(@all_payments.first.email).email == nil
      @url = payments_url(:auth_token => User.find_by_email(@all_payments.first.email).authentication_token)
    else
      @url = payments_url
    end 

    mail(:to => @all_payments.first.email, :subject => "Reminder that you owe some money", :cc => User.find(@all_payments.first.user_id).email)
  end

end
