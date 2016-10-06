class LeaveApplication < ActiveRecord::Base
	belongs_to :staff
	belongs_to :leave_type
end

