module SchedulesHelper

def timeheader(tms)	
	result=""
	result+="<td colspan=3 style='background-color: green;color:white'>Thurs</td>
	<td colspan=7 style='background-color: green;color:white'>Fri</td>
	<td colspan=7 style='background-color: green;color:white'>Sat</td>
	<td colspan=7 style='background-color: green;color:white'>Sun</td>
	<td colspan=3 style='background-color: green;color:white'>Mon</td>"
	result+="<tr><td/>"
	tms.each do |t| 
		result+="<td style='background-color: lightblue'>"
		result+=t.strftime("%I %p")
		result+="</td>"
	end
	result+="</tr>"
	result
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
	 result=""
	 result+="<td style='background-color:lightgreen;'>"
	result+=name 
	result+="</td>"
	result

	i=0
	if shfs==nil
	return #name+' has nil shifts'
	end
	
	 shfs.each do |k| 
		 while tms[i] < k.start && i <tms.size-1
				result+="<td></td>"
				i+=1
		end
		result+="<td>"+k.location.name+"</td>"	
		i+=1
	end
	
	while i<tms.size do
		result+="<td></td>"
		i+=1
	end
	
	result
end
def cell_color(sh)
	
	if flash[:bad_cells]==sh.id
	return "red"
	end
	
end
end
