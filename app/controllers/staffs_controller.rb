class StaffsController < ApplicationController
		before_action :set_staff, only: [:edit, :update, :show]
	def new
		@staff = Staff.new()
		authorize @staff
	end

	def create
		# @user = User.new(email:staff_params[:email],password: 123456,category:"staff")
		@staff = Staff.new(staff_params)
		authorize @staff
		if @staff.save
			invite= Invite.create(email:@staff.email)
			invite.invite!
			redirect_to	send_invitation_url(invite.id)
		else
	    	render template: "staffs/new"
		end
	end

	def index
		@staffs = Staff.all
		@active_staffs = []		
		Contract.where(status:1).each do |contract|
			@active_staffs << Staff.find(contract.staff_id)
		end

		# Contract.where("end_date>?", Time.now).each do |contract|
		# 	@active_staffs<< Staff.find(contract.staff_id)
		# end 
		@inactive_staffs = Staff.all-@active_staffs

		#possible to run ajax for asynchrous index display?
	end

	def edit

	end

	def update
		@staff.update(staff_params)
		redirect_to root_path
	end

	def show
		@contract = @staff.contracts
	end

	def filter_staff_by_contracts
		contracts = Contract.where("commencement_date > ? AND end_date < ?",params[:date_from],params[:date_to])
		filtered_staffs = []
		contracts.each do |contract|
			staff = Staff.find(contract.staff_id)
			filtered_staffs << [staff,staff.attributes.values.include?(nil)]
		end

		filtered_staffs
		render :json => filtered_staffs
	end

	private
	def staff_params
		params.require(:staff).permit(:email,:name,:full_name, :identification_number, :contact_number,:address,:date_of_birth,{identification_documents: []})
	end

	def set_staff
		@staff = Staff.find(params[:id])
	end
end
