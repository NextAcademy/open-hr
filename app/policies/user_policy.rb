class UserPolicy < ApplicationPolicy
	# def new?
	# 	user.admin? or user.hr?
	# end

	def create?
		if record.category == "admin"
			if !user.nil?
				user.admin?
			else
				User.all.empty?
			end
		elsif record.category == "hr" || record.category == "staff" || record.category == "no_role"
			false
			user.admin? if !user.nil?
		end
	end
end	