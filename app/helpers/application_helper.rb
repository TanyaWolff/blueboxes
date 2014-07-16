# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
def yes_or_no(b)
  result=''
  result='y' if b
  result
end
def getGateScheduleId
  @gate_schedule_id=Schedule.all.collect{|s| s.id}.max
  end
def trc(c)
  lk=link_to('Show', c)
  om='... '.concat(lk)
  truncate(c.entry, :length => 1000, :omission => om)
 end

def area_choices(tab)
	select(tab, "area_id", Area.all.collect{ |a| [ a.name, a.id] }, :include_blank=>:false)
end
def car_disp 
	return ''
	file='cars/car'+rand(20).to_s+'.jpeg'
	image_tag(file)
end
def thumb (record)
	return ""
	if record.instance_of? Volunteer  then 
		if record.picture_id then
			p="uploads/"+Picture.find(record.picture_id).name
			return  image_tag(p, :width=>"40px", :height=>"40px")
		#return url_for(:controller=>'gallery', :action=>'picture', :id=>record.picture_id) 
		end
	else 
		
	
	if File.exists?("public/images/"+record.name+"_thm.JPG") then
		image_tag(record.name+'_thm.JPG')
	elsif File.exists?("public/images/"+record.name+".JPG") then
		image_tag(record.name+'.JPG')
	elsif !record.picture_id.nil? then
		"in"
	else
		"out"
	#pic = Picture.find_by_name(record.last_name+record.id+".JPG") 
	#if pic then
	#	                 image_tag(pic.name)
	#end
	#elsif record instanceof volunteer then
	#	if record.key then
		
	#		image_tag("key1.png")
	#	elsif record.hat then
	#		image_tag("hat1.png")
		
	#	end	
	#else "Out"
	end
	end
	end
	def sleeps
	return Date.new(2013,8,2) - Date.today 
	end
end
