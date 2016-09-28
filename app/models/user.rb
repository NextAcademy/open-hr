class User < ActiveRecord::Base
  include Clearance::User
  enum category: {
    'admin': 0,
    'hr': 1,
    'staff': 2,
    'no_role': 3
  }


end
