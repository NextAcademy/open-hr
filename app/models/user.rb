class User < ActiveRecord::Base
  include Clearance::User
  validates :category, presence: true
  enum category: {
    'admin': 0,
    'hr': 1,
    'staff': 2,
    'no_role': 3
  }


end
