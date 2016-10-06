class ContractsController < ApplicationController
	before_action :set_staff
	def new
		@contract = @staff.contracts.new()
	end

	def create
		@contract = Contract.new(contract_params)
		if @contract.save
			redirect_to root_path
		else
			render template: "contracts/new"
		end

	end

	def terminate
	end

	private
	def contract_params
		params.require(:contract).permit(:job_title,:salary,:commencement_date, :end_date, :status,{contract_documents: []})
	end

	def set_staff
		@staff= Staff.find(params[:staff_id])
	end
end
