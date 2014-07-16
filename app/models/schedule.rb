class Schedule < ActiveRecord::Base
  belongs_to :area
  has_many :shifts, :dependent=>:destroy, :order=>"start, location_id"
  has_and_belongs_to_many :locations
  has_many :volunteers
  validates_presence_of :start, :area_id

  after_create :create_shifts
  
  @@slots_per_day=[[12,14,16,18], [8,10,12,14,16,18,20],[8,10,12,14,16,18,20],[8,10,12,14,16,18,20],[9,11,13]]

  attr_accessor :pending


  def self.slots_per_day
	@@slots_per_day
  end 
  def add_shift(shift)
     @shifts << shift
  end

  # sets both shifttimes and shifttimes_per_day which is similar to slots_per_day but tailored to the schedule. Eg Parking2013 schedule started at 2, not noon.
  def shifttimes
    if @shifttimes.nil?
	setshifttimes
    end
    @shifttimes
  end

  def shifttimes=
	@shifttimes=[]
	@@slots_per_day.each_with_index  do |d, i|
	    n=(self.start+i).to_time
	    d.each do |t|
		    @shifttimes<< n+(t*3600)
	    end
	end
  end   
  def shifttimes_per_day
    if @shifttimes_per_day.nil?
	setshifttimes
    end
    @shifttimes_per_day
  end
  def shifttimes_per_day=(st)
	@shifttimes_per_day=st
  end
  def setshifttimes
	@shifttimes=[]
	@shifttimes_per_day=@@slots_per_day
 	if self.year < 2014
		@shifttimes_per_day[0]=[14,16,18]
	end
	@shifttimes_per_day.each_with_index  do |d, i|
	    n=(self.start+i).to_time
	    d.each do |t|
		    @shifttimes<< n+(t*3600)
	    end
	end
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
	self.shifts=[]
	if self.locations.size==0
	  self.locations=self.area.locations
	end
	st=self.shifttimes  
    	st.each do |t|
		self.locations.each do |l|
		
			shift=Shift.new
			shift.location=l
			shift.start=t
			self.shifts << shift
		end
    	end
  end
  
  
  
end
