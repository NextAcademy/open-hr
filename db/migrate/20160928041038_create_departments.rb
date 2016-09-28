class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :head_of_department

      t.timestamps null: false
    end
  end
end
