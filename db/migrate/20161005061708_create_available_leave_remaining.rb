class CreateAvailableLeaveRemaining < ActiveRecord::Migration
  def change
    create_table :available_leave_remainings do |t|
      t.float	:number_of_days, default: 0
      t.belongs_to	:leave
      t.belongs_to	:contract
    end
  end
end
