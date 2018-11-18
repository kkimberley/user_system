class UserMailer < ApplicationMailer
  default from: 'kimberley@example.com'

  def welcome_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Signup successfully.')
  end
end
