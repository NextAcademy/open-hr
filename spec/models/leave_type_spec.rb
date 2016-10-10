require 'rails_helper'

RSpec.describe LeaveType, :type => :model do
	describe LeaveType do
		it "is valid with leave_type_name and unpaid_leave" do
			leave_type = LeaveType.new(leave_type_name:"Annual", unpaid_leave:false)
			expect(leave_type).to be_valid
		end

		it "is invalid without leave_type_name" do
			leave_type = LeaveType.new(leave_type_name:nil, unpaid_leave:false)
			expect(leave_type).to_not be_valid
		end

		it "is invalid without unpaid_leave" do
			leave_type = LeaveType.new(leave_type_name:"Annual", unpaid_leave:nil)
			expect(leave_type).to_not be_valid
		end

		it "is invalid with a duplicate name" do
			leave_type = LeaveType.new(leave_type_name:"Annual", unpaid_leave:false)
			leave_type.save
			leave_type_duplicate = LeaveType.new(leave_type_name:"Annual", unpaid_leave:true)
			expect(leave_type_duplicate).to_not be_valid
		end

		it "is invalid with more than one true unpaid leave record" do
			leave_type_true = LeaveType.new(leave_type_name:"Annual", unpaid_leave:true)
			leave_type_true.save
			leave_type_duplicate_true = LeaveType.new(leave_type_name:"Unpaid", unpaid_leave:true)
			expect(leave_type_duplicate_true).to_not be_valid
		end
	end
end
