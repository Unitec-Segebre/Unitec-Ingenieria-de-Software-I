module ApplicationHelper
	def format_date(date)
		return nil unless date
		date.strftime("%d / %m / %Y")
	end

	def modal_button(type, icon, string)
		button_tag(type: 'button', class: "btn #{type} btn-outline btn-lg", data: {toggle: 'modal', target: '#myModal'}, onClick:"focus_field('#field1')", style: 'margin-bottom:20px') do
			content_tag(:span, "", class: "fa #{icon}") +
			" " +
			string
		end
	end

  def return_button(path)
		link_to path, class: "btn btn-outline btn-danger btn-lg", style: "margin-bottom: 20px" do
			content_tag(:span, "", class: "fa fa-mail-reply") +
			" " +
			"Regresar"
    end
	end

end
