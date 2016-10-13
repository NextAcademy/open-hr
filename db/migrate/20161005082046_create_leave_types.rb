class CreateLeaveTypes < ActiveRecord::Migration
  def change
    create_table :leave_types do |t|
      t.string	:leave_type_name
      t.boolean	:unpaid_leave, default: false
      t.float 	:default_amount
      t.timestamps null: false
    end
  end
end
