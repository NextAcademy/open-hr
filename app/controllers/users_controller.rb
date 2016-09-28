class UsersController < Clearance::UsersController
	before_action :login_required, only: [:new,:create]
	def new
		@user=User.new()
	    render template: "users/new"
	end

	def create
		@user=User.new(user_params)
		authorize @user
		if @user.save
			redirect_to root_path
		else
			flash="Sign up failed."
	    	render template: "users/new"
		end
				
	end

	def dashboard
	end



	private

	def login_required
		redirect_to sign_in_path if !User.find_by(category:'admin').nil? && current_user.nil?
	end

	def user_params
		params.require(:user).permit(:email,:password,:category)
	end

	def redirect_signed_in_users
	  if signed_in?
	  	if current_user.staff? || current_user.no_role?
	    	redirect_to Clearance.configuration.redirect_url
	    end
	  end
	end
end
