class AvailableRemainingLeave < ActiveRecord::Base
	belongs_to :contract
	belongs_to :leave_type
end