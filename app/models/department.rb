class Department < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true
	# validates :head_of_department, presence: true
end
