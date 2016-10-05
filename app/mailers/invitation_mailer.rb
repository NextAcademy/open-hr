class InvitationMailer < ApplicationMailer

	def invite(invitation)
	  @invite = invitation
	  mail :to => invitation.email,
	       :subject => "Welcome to the Company!"
	end
end
