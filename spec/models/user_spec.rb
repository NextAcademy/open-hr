require 'rails_helper'

RSpec.describe User, :type => :model do
	describe User do

    	it { should allow_values(0,1,2,3).for(:category) }

		it { should validate_presence_of(:category) }

		it "raise error for invalid category" do
			expect {User.new(email:"test@test.com",password:"12345",category:4)}.to raise_error(ArgumentError)
		end

	end
end
