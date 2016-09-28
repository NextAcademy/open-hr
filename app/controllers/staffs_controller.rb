	class StaffsController < ApplicationController
	def new
		@staff = Staff.new()
		authorize @staff
	end

	def create
		@user = User.new(email:staff_params[:email],password: 123456,category:"staff")
		@staff = Staff.new(staff_params)
		authorize @staff
		if @staff.save
			@user.save
			redirect_to root_path
		else
	    	render template: "staffs/new"
		end
	end

	private
	def staff_params
		params.require(:staff).permit(:email,:name)
	end

end
