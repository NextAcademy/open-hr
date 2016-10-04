class InvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite.subject
  #
	def invite(invitation)
	  @invite = invitation
	  mail :to => invitation.email,
	       :subject => "Welcome to the Company!"
	end
end
