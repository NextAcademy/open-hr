class UserMailer < ApplicationMailer
  default from: 'invitation@open_hr.com'

  def invitation_email(user)
    @user = user
    @url  = 'http://open_hr.com/login'
    mail(to: @user.email, subject: 'User Account Invitation')
  end
end
