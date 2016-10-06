class LeaveType < ActiveRecord::Base
	has_many :contracts,through: :available_remaining_leaves
	has_many :available_remaining_leaves, class_name:"AvailableRemainingLeave",foreign_key:"leave_type_id"
	has_many :leave_applications
    # named_scope :is_unpaid_leave, :conditions => {:unpaid_leave => true}

	def validate
	  errors.add_to_base "You can only have one type that is unpaid leave" unless self.unpaid_leave_valid?
	end

	def unpaid_leave_valid?
	  self.unpaid_leave == false || LeaveType.is_unpaid_leave.size == 0 || ( LeaveType.is_unpaid_leave.size == 1 && !self.unpaid_leave_changed?)
	end

end
 	