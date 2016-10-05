class InvitesController < ApplicationController
	def send_invitation
	  @invite = Invite.find(params[:id])
	  mail = InvitationMailer.invite(@invite)
	  mail.deliver
	  redirect_to(root_url, :notice => "Invite sent to #{@invite.email}")
	end
end
