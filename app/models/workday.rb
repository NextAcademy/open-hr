class Workday < ActiveRecord::Base
	validates :workdate, uniqueness:true
end
