class Setting < ActiveRecord::Base
	def create_work_day_entires(rules)
		date_now= Date.today
		database_new_entry = []
		(date_now..date_now.end_of_year).each do |date|

			database_entry.push "('#{date}','#{}')"
		end
		sql = "INSERT INTO workdays (workdate,full_or_half) VALUES #{database_entry.join(",")}"
		Workday.connection.execute "#{{sql}}"
	end
end

