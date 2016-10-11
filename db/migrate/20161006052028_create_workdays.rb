class CreateWorkdays < ActiveRecord::Migration
  def change
    create_table :workdays do |t|
      t.date	:workdate
      t.float	:full_or_half
      t.boolean	:holiday, default:false
      t.string	:holiday_name
      t.timestamps null: false
    end
  end
end
