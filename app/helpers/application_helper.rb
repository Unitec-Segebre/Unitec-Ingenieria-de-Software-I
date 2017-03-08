module ApplicationHelper
	def format_date(date)
		return nil unless date
		date.strftime("%d / %m / %Y")
	end
end
