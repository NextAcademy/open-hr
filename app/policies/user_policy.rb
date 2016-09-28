class UserPolicy < ApplicationPolicy
	def new?
		user.admin? or user.hr?
	end

	def create?
		if record.category == "admin" || record.category == "hr"
			User.all.empty? or user.admin? 
		elsif record.category == "staff" || record.category == "no_role"
			user.admin? or user.hr?
		end
	end
end	