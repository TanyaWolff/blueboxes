module AreasHelper
def pretty_list(list)
	content_tag(:td, class: "area") do
		list.each do |n|
			concat content_tag(:li, n) 
		end
	end
end

def profile(vid)
return "link_to (:controller=>'volunteers',:action=>'edit', :id=>vid)"
end


end
