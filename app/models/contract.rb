class Contract < ActiveRecord::Base
	belongs_to :staff
	belongs_to :department
	has_many :leave_types,through: :available_remaining_leaves
	has_many :available_remaining_leaves, class_name:"AvailableRemainingLeave", foreign_key:"contract_id"

	  mount_uploaders :contract_documents, ContractDocumentUploader
end
