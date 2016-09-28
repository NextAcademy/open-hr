class DepartmentPolicy < ApplicationPolicy
	def new?
		user.admin? or user.hr?
	end

	def create?
		user.admin? or user.hr?
	end
end	