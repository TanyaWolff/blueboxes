class Shift < ActiveRecord::Base
  belongs_to :location
  belongs_to :volunteer
  belongs_to :schedule

def self.find_shifts_at(loc)
  Shift.find_all(:location_id => loc.id) 
end
def self.find_shift(loc, time)
  Shift.find(:first,
		 :conditions => ["location_id = ? and start = ?", loc.id, time]) 
end

end
