require "rails_helper"

RSpec.describe SignUpConfirmationMailer, :type => :mailer do
  describe "confirmation" do
  	let(:user){User.new(email:"test@test.com",password:123456)}
    let(:mail){SignUpConfirmationMailer.confirm(user)}

    it "renders the headers" do
      expect(mail.subject).to eq("Your Signup is Successful")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["testatester37@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Congratulations on a successful sign up")
    end
  end

end
