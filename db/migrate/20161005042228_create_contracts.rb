class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to	:staff
      t.belongs_to	:department
      t.string 		:job_title
      t.float		:salary
      t.datetime	:commencement_date
      t.datetime  :end_date
      t.json      :contract_documents
      t.timestamps null: false
    end
  end
end
