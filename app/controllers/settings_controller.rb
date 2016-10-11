class SettingsController < ApplicationController
	before_action :set_setting
	def show
		@authority = params[:authority]
		render template:"users/settings"
	end

	def set_work_days
		original_setting_rules = @setting.rules
		@setting.update(rules:{work_days:params[:work_days],half_days:params[:half_days],off_days:params[:off_days]})
		create_work_day_entries(@setting.rules) if (Date.today..Date.today.end_of_year).include?
		render template:"users/settings"
	end

	private

	def set_setting
		if Setting.all.empty?
			@setting = Setting.new(rules:{work_days:[],half_days:[],					off_days:[],})
			@setting.save
		else
			@setting=Setting.last
		end
	end
end
