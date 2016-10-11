class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.json :rules
      t.timestamps null: false
    end
  end
end
