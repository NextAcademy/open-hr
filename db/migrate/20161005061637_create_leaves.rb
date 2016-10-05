class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.string	:leave_type
      t.timestamps null: false
    end
  end
end
