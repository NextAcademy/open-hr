class SessionsController < Clearance::SessionsController

  def new
	admin_users = User.find_by(category:'admin')
	if admin_users.nil?
		@user = User.new
	    redirect_to new_user_path
	else
		render template: "sessions/new"
	end
  end

end