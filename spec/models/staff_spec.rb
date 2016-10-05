require 'rails_helper'

RSpec.describe Staff, :type => :model do
	describe Staff do
		it "is valid with name and email" do
			staff = Staff.new(name:"John", email:"test@gmail.com")
			expect(staff).to be_valid
		end

		it "is invalid without name" do
			staff = Staff.new(name: nil, email:"test@gmail.com")
			expect(staff).to_not be_valid
		end

		it "is invalid without email" do
			staff = Staff.new(name: "John", email:nil)
			expect(staff).to_not be_valid
		end

		it "is invalid with a duplicate address" do
			staff = Staff.new(name: "John", email:"test@gmail.com")
			staff.save
			staff_duplicate = Staff.new(name:"Jack", email:"test@gmail.com")
			expect(staff_duplicate).to_not be_valid
		end
	end
end
