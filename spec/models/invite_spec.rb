require 'rails_helper'

RSpec.describe Invite, :type => :model do
 
	describe Invite do 

		it {should validate_presence_of(:email)}

		it {should validate_uniqueness_of(:email)}

		let(:invite) { Invite.new(email:"test1@test.com") }

		describe ".invite!" do
			it "changes value of invite_code and invited_at attributes " do
				original =[invite.invite_code, invite.invited_at] 
				invite.invite!
				expect([invite.invite_code, invite.invited_at] ).to_not eq (original)
			end
		end

		describe ".invited?" do

			it "returns true when valid" do
				invite.invite!
				expect(invite.invited?).to eq true
			end

			it "returns false without invite_code" do
				invite.invited_at=Time.now.utc
				invite.save
				expect(invite.invited?).to_not eq true
			end

			it "returns false without invited_at" do
				invite.invite_code=Digest::SHA1.hexdigest("--#{Time.now.utc.to_s}--#{invite.email}--")
				invite.save
				expect(invite.invited?).to_not eq true
			end
		end

		describe ".redeemed!" do
			it "changes value of redeemed_at attribute " do
				original=invite.redeemed_at
				invite.redeemed!
				expect(invite.redeemed_at).to_not eq (original)
			end
		end
	end

	describe ".find_redeemable" do
		it "returns scoped records" do
			invite= Invite.new(email:"test1@test.com")
			invite.invite!
			invite.redeemed!
			invite_2= Invite.new(email:"test@test.com")
			invite_2.invite!
			invite_3=Invite.new(email:"john@john.com")
			invite_3.invite! 
			expect(Invite.find_redeemable(invite_2.invite_code)).to eq invite_2
		end
	end
end
