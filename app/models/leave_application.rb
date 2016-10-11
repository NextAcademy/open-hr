class LeaveApplication < ActiveRecord::Base
	belongs_to :staff
	belongs_to :leave_type
	enum status: {
      'pending': 0,
      'approved': 1,
      'not_approved':2
  	}
end

