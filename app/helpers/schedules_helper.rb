module SchedulesHelper

 def timeheader(tms)
    @content = content_tag(:tr, class: "days") do
	concat content_tag(:td, tms[0].year, class: "names")
	concat "<td colspan='3'>Thurs</td>".html_safe
	concat "<td colspan='7'>Fri</td>".html_safe
	concat "<td colspan='7'>Sat</td>".html_safe
	concat "<td colspan='7'>Sun</td>".html_safe
	concat "<td colspan='3'>Mon</td>".html_safe
    end
    @content << "<tr><td></td>".html_safe
    tms.each do |t|
	@content << content_tag(:td, t.strftime("%l%p").downcase, class: "times") 
    end
    @content
 end
 def status(y)
	 return "draft" if y==0
	 return "review" if y==1
	 return "final" if y==2
 end
 
 def vol_row(v,shfs,tms)
	if v==nil
	 return "nil" 
	 end
	name=v.name
	@content = "<tr>".html_safe
	@content << content_tag(:td, name, class: "sched")

	i=0
	if shfs==nil
	return #name+' has nil shifts'
	end
	
	 shfs.each do |k| 
		 while tms[i] < k.start && i <tms.size-1
				@content << "<td></td>".html_safe
				i+=1
		end
		@content << content_tag(:td, k.location.name)
		i+=1
	end
	
	while i<tms.size do
		@content << content_tag(:td, '')
		i+=1
	end
	
	@content << "</tr>".html_safe
	@content
end
def cell_color(sh)
	
	if flash[:bad_cells]==sh.id
	return "red"
	end
	
end
end
