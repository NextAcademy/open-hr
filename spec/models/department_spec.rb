require 'rails_helper'

RSpec.describe Department, :type => :model do
	describe Department do
		it "is valid with name and head_of_department" do
			department = Department.new(name:"John", head_of_department:"John")
			expect(department).to be_valid
		end

		it "is invalid without name" do
			department = Department.new(name:nil, head_of_department:"John")
			expect(department).to_not be_valid
		end
	end
end
