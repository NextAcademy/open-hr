class SettingsController < ApplicationController
	before_action :set_setting
	def show
		@authority = params[:authority]
		render template:"users/settings"
	end


	def set_work_days
		byebug
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
			byebug
			Setting.update_work_day_entries(@setting.rules)
		end

		render template:"users/settings"
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
end
