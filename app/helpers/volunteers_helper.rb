module VolunteersHelper

def signed_up(v)
	return false if v.signups.empty?
	thisyear=Date.today.year
	return v.signups.last.year == thisyear
end
def thursday_list(v)
	return false if v.signups.empty?
	s=v.signups.last
	thisyear=Date.today.year
	return false if s.year != thisyear
	return s.early
end
def su_disp(v)
	return 1
end
def portrait(pic)
	return "No pic" if !pic
	image_tag("uploads/#{pic.name}")
end

def best_location_choices
	select("volunteer", "best_loc", Location.all.collect{ |loc| [ loc.name, loc.id] }, :include_blank=>:true)
end
def worst_location_choices
	select("volunteer", "worst_loc", Location.all.collect{ |loc| [ loc.name, loc.id] }, :include_blank=>:true)
end

def loc_disp(i)
	return 0 if i.nil?
	Location.find(i).name
end
# display active record list as "Name1 <email1>","Name2 <email2>",
def display_emails(list) 
  	content_tag(:table, align: "center") do
  	content_tag(:tr) do
  	content_tag(:td) do
  	content_tag(:ul, class: "nobullets") do
                list.each do |n|
                        concat content_tag(:li,"#{n.name} <#{n.email}>,")
                end
	end
	end
        end
	end
end
def time_disp(i)
	result=case i
		when 0 then image_tag("happy.png")
		when 1 then image_tag("dontcare.png")
		when 2 then image_tag("sad.png")
		
	end
			
end
def time_d (i)
	i=1 if i.nil?
	["yes!","---","\#@$!"][i]
end
def ok_disp (b)
	result=case b
		when true then "y" # image_tag("check.png", :width=>"15px", :height=>"15px")	
	end
end



def get_icon (volunteer, screen)
	if !screen then
		if volunteer.hat then "hat"
		elsif volunteer.key then "key"
		else "out"
		end
	else
		
		#p=Picture.find(1)		
		#return image_tag url_for(:controller=>'gallery', :action=>'picture', :id=>1)
		if volunteer.share? || session[:isHat] then
			link_to  thumb(volunteer), :action => :show, :id => volunteer.id
		else
			thumb(volunteer)
		end
	end
end
end
