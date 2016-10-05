class SignUpConfirmation < ApplicationMailer
	def confirmation(user)
	  @user = user
	  mail :to => user.email,
	       :subject => "Welcome to the Company!"
	end
end
