class SignUpConfirmationMailer < ApplicationMailer
	def confirm(user)
	  @user = user
	  mail :to => user.email,
	       :subject => "Your Signup is Successful"
	end
end
