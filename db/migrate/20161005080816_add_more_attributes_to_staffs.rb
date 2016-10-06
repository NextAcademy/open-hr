class AddMoreAttributesToStaffs < ActiveRecord::Migration
  def change
  	add_column :staffs, :full_name, :string
  	add_column :staffs, :identification_number, :string
  	add_column :staffs, :contact_number, :string
  	add_column :staffs, :address, :string
  	add_column :staffs, :date_of_birth, :datetime
  	add_column :staffs, :identification_documents, :json
  end
end
