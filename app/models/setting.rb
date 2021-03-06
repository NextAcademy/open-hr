class Setting < ActiveRecord::Base
	# after_initialize :prevent_null

	# def prevent_null
	# 	self.rules["work_days"]||= []
	# 	self.rules["half_days"]||= []
	# 	self.rules["off_days"]||=[]
	# end

	def self.create_work_day_entries(rules)
		date_now= Date.today
		database_new_entry = []
		(date_now..date_now.end_of_year).each do |date|
			day_number = date.cwday.to_s
			day_float = 1
			next if rules["off_days"].include?(day_number)
			day_float = 0.5 if rules["half_days"].include?(day_number)
			database_new_entry.push "('#{date}','#{day_float}','#{Time.now}','#{Time.now}')" 
		end
		sql = "INSERT INTO workdays (workdate,full_or_half,created_at,updated_at) VALUES #{database_new_entry.join(",")}"
		Workday.connection.execute "#{sql}"
	end

	def self.update_work_day_entries(rules)
		date_now= Date.today
		database_new_entry = []
		database_update_half_entry = []
		database_update_full_entry = []
		database_delete_entry = []
		(date_now..date_now.end_of_year).each do |date|
			day_number = date.cwday.to_s
			day_float = 1
			day_float = 0.5 if rules["half_days"].include?(day_number)
			if !!Workday.find_by(workdate:date)
				if rules["off_days"].include?(day_number)
					database_delete_entry.push "'#{date}'" 
				else
					database_update_half_entry.push "'#{date}'" if rules["half_days"].include?(day_number)
					database_update_full_entry.push "'#{date}'" if !rules["half_days"].include?(day_number)
				end
			else
				next if rules["off_days"].include?(day_number)
				database_new_entry.push "('#{date}','#{day_float}','#{Time.now}','#{Time.now}')" 
			end
		end
		sql_delete = "DELETE FROM workdays WHERE workdate IN (#{database_delete_entry.join(",")})"
		sql_update_half = "UPDATE workdays SET (full_or_half) = (0.5) WHERE workdate IN (#{database_update_half_entry.join(",")})"
		sql_update_full = "UPDATE workdays SET (full_or_half) = (0.5) WHERE workdate IN (#{database_update_full_entry.join(",")})"
		sql_new = "INSERT INTO workdays (workdate,full_or_half,created_at,updated_at) VALUES #{database_new_entry.join(",")}"
		byebug
		Workday.connection.execute "#{sql_delete}" if !database_delete_entry.empty?
		Workday.connection.execute "#{sql_update_half}" if !database_update_half_entry.empty?
		Workday.connection.execute "#{sql_update_full}" if !database_update_full_entry.empty?
		Workday.connection.execute "#{sql_new}"	if !database_new_entry.empty?
	end
end

