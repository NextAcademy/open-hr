class CreateLeaveApplications < ActiveRecord::Migration
  def change
    create_table :leave_applications do |t|
      t.belongs_to	:staff
      t.belongs_to	:leave_type
      t.text	:description
      t.string	:status
      t.date	:start_date
      t.date 	:end_date
      t.timestamps null: false
    end
  end
end
