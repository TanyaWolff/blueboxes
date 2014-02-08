module ParkingHelper

def find_shift(loc, time) 
    shift=Shift.find_shift(loc, time)
    if shift==nil
    	shift = Shift.new()
    	shift.location_id=loc.id
    	shift.start=time
      shift.save
    end
    shift
  end

end

def display_by_volunteer(v)
    nShifts=@shifttimes.size
   
    vshifts=v.shifts
   vol_locs=[]
  
   if vshifts.size > 0
     
       
       i=0

       
       vshifts.each do |sh|
         
         return vol_locs if i==27
         ss=@shifttimes[i]
         s=ss.utc
         
         t=sh.start.utc
         
         until s==t 
            vol_locs << ""
            
    	      i+= 1
            return vol_locs if i==27
            s=@shifttimes[i].utc
         end
         
         vol_locs << sh.location.name
         
         i+= 1
         
         
       end 
         #fill the rest of the row with blanks
         
         until i ==27
    	     vol_locs << ""
           i += 1
         end
      
       
    else
       nShifts.times do 
        vol_locs << ""
       end
    end
    return vol_locs
   
end
