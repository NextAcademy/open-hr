class DepartmentsController < ApplicationController
	def new
		@department = Department.new()
		authorize @department
	end

	def create
		@department = Department.new(department_params)
		authorize @department
		if @department.save
				flash[:warning]  = "There is no head of department for #{@department.name}!" if @department.head_of_department == ""
			redirect_to root_path
		else
			render template: "departments/new"
		end
	end

	private
	def department_params
		params.require(:department).permit(:name,:head_of_department)
	end
end
