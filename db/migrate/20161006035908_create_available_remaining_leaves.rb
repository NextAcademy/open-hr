class CreateAvailableRemainingLeaves < ActiveRecord::Migration
  def change
    create_table :available_remaining_leaves do |t|
      t.belongs_to	:contract
      t.belongs_to 	:leave_type
      t.float		:number_of_days, default: 0
      t.timestamps null: false
    end
  end
end
