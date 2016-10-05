class UsersController < Clearance::UsersController

	before_action :login_required, only: [:new,:create] 
	def new
		@user=User.new()
		invite_code = request.original_url.split("/").last
		@invite = Invite.find_redeemable(invite_code) if invite_code != "signup"
	    render template: "users/new"
	end

	def create
		@user=User.new(user_params)
		invite_code = request.referrer.split("/").last
		@invite = Invite.find_redeemable(invite_code)
		if @invite.nil?
			authorize @user 
			if @user.save
				redirect_to root_path
			else
				flash[:notice] ="Sign up failed."
		    	render template: "users/new"
			end
			return
		end
	    if invite_code && @invite && @invite.email == @user.email
	    	authorize @user, :staff_invite_sign_up?
	      if @user.save
	        @invite.redeemed!
	        SignUpConfirmationMailer.confirm(@user).deliver
	        flash[:notice] = "You will receive an email within the next few minutes. " <<
	                         "It contains instructions for confirming your account."
	        redirect_to root_path
	      else
	      	flash[:notice] ="Sign up failed."
	        render :action => "new"
	      end
	    else
	      flash[:notice] = "Sorry, that code is not redeemable"
	      redirect_to root_path
		end
	end

	def dashboard

	end



	private

	def login_required
		params[:invite_code]||= request.referrer.split("/").last if !request.referrer.nil?
		redirect_to sign_in_path if !User.find_by(category:'admin').nil? && !signed_in? && Invite.find_by(invite_code:params[:invite_code]).nil?
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
