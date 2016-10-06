class Department < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true
	has_many :contracts
end
