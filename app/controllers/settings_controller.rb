class SettingsController < ApplicationController
	before_action :set_setting
	def show
		@authority = params[:authority]
		@leave_types = LeaveType.all
		render template:"users/settings"
	end


	def set_work_days
		original_setting_rules = @setting.rules
		#improve this!
		params[:work_days] = [] if params[:work_days] == nil
		params[:half_days] = [] if params[:half_days] == nil
		params[:off_days] = [] if params[:off_days] == nil

		@setting.update(rules:{work_days:params[:work_days],half_days:params[:half_days],off_days:params[:off_days]})

		last_day=Workday.pluck(:workdate).sort.last
		if  original_setting_rules == @setting.rules
		elsif last_day == nil || last_day < Date.today
			Setting.create_work_day_entries(@setting.rules) 
		else
			Setting.update_work_day_entries(@setting.rules)
		end

		redirect_to settings_path(current_user.category)
	end

	def set_leave_type
		leave_type=LeaveType.new(leave_type_params)

		if leave_type.save
			flash[:notice] = "You have successfully created a new leave type"
		else
			flash[:warning]= "Your leave type input was incorrect"
		end

		redirect_to settings_path(current_user.category)
	end

	def load_calendar
		dates = Workday.all.pluck(:workdate)
		render :json => dates
	end

	private

	def set_setting
		if Setting.all.empty?
			@setting = Setting.new(rules:{work_days:[],half_days:[],off_days:[],})
			@setting.save
		else
			@setting=Setting.last
		end
	end

	def leave_type_params
		params.require(:leave_type).permit(:leave_type_name,:default_amount,:unpaid_leave)
	end
end
