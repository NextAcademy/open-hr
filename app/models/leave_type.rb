class LeaveType < ActiveRecord::Base
	validates :leave_type_name, presence: true, uniqueness: true
	validates_inclusion_of :unpaid_leave, in: [true, false]
	validates_uniqueness_of :unpaid_leave, :if => :unpaid_leave

	has_many :contracts,through: :available_remaining_leaves
	has_many :available_remaining_leaves, class_name:"AvailableRemainingLeave",foreign_key:"leave_type_id"
	has_many :leave_applications

end
 	