require "rails_helper"

RSpec.describe InvitationMailer, :type => :mailer do
  describe "invite" do
    let(:invitation){ 
      Invite.new(email:"test@test.com").invite!
      Invite.find_by(email:"test@test.com")
    }
    let(:mail){InvitationMailer.invite(invitation)}

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to the Company!")
      expect(mail.to).to eq([invitation.email])
      expect(mail.from).to eq(["testatester37@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Invitation to Sign Up")
    end
  end

end
