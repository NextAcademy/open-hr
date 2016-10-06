class Staff < ActiveRecord::Base
	validates :email, email: { strict_mode: true }, presence: true, uniqueness: { allow_blank: true }
	validates :name, presence: true

	has_many :contracts
	has_many :leave_applications
	mount_uploaders :identification_documents, IdentificationDocumentUploader
end
