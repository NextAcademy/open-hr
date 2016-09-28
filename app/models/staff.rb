class Staff < ActiveRecord::Base
	validates :email, email: { strict_mode: true }, presence: true, uniqueness: { allow_blank: true }
end
