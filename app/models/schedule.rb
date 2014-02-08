class Schedule < ActiveRecord::Base
  belongs_to :area
  has_many :shifts, :dependent=>:destroy, :order=>"start, location_id"
  has_and_belongs_to_many :locations
  has_many :volunteers
  #has_many :volunteers, :through=>:shifts
  #attr_accessor  :slots
  validates_presence_of :start, :area_id
 
 
  def self.add_shift(shift)
     @shifts << shift
  end
  def after_create
	  self.shifts=create_shifts
	  
  end
  
  def getshifttimes
	shifttimes=[]
    first_day = self.start.to_time.localtime+(16*3600)
    slots_per_day=[[14,16,18], [8,10,12,14,16,18,20],[8,10,12,14,16,18,20],[8,10,12,14,16,18,20],[9,11,13]]
    slots_per_day.each_with_index  do |d, i|
	    n=(self.start+i).to_time
	    d.each do |t|
		    shifttimes<< n+(t*3600)
	    end
   end
    shifttimes
  end   
  def add_location(loc)
	  return if self.locations.include?(loc)
	  self.locations << loc 
          st=getshifttimes
          st.each do |t|
		shift=Shift.new
		shift.location=loc
		shift.start=t
		self.shifts << shift
	  end
    end
  
  protected
  # to be done after locations is set
  def create_shifts
	  shifts=[]
	  if self.locations.size==0
		  self.locations=self.area.locations
	  end
	  
    #locations=Location.all
    st=getshifttimes
    st.each do |t|
	self.locations.each do |l|
        
        shift=Shift.new
        shift.location=l
        shift.start=t
        shifts << shift
      end
    end
    shifts
  end
  
  
  
end
