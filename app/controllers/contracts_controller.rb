class ContractsController < ApplicationController
	before_action :set_staff	
	before_action :set_contract, only: [:edit,:update,:activate,:terminate]
	def new
		@contract = @staff.contracts.new()
	end

	def create
		@contract = @staff.contracts.new(contract_params)
		if @contract.save
			redirect_to root_path
		else
			render template: "contracts/new"
		end

	end

	def edit
	end

	def update
		@contract.update(contract_params)
		redirect_to staff_path(@staff)
	end

	def activate
		byebug
		@contract.update(status:1)
		redirect_to staff_path(@staff)
	end

	def terminate
		@contract.update(status:0)
		redirect_to staff_path(@staff)
	end

	private
	def contract_params
		params.require(:contract).permit(:job_title,:salary,:commencement_date, :end_date, :status,{contract_documents: []})
	end

	def set_staff
		@staff= Staff.find(params[:staff_id])
	end

	def set_contract
		@contract = Contract.find(params[:id])		
	end
end
