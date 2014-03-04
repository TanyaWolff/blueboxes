class SchedulesController < ApplicationController
	before_filter :check_admin, :except=>['index', 'show', 'print', 'print2', 'save','save2']
	
	#caches_page :show
  # GET /schedules
  # GET /schedules.xml
  
  def index
    @schedules = Schedule.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schedules }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.xml
  def show
	@schedule = Schedule.find(params[:id])
	if @schedule.start != @schedule.shifts[0].start then
		#flash[:notice]="Warning: schedule starts at ", @schedule.start.to_s," but shifts start at ",@schedule.shifts[0].start.to_s
	end
	@shift_days=@schedule.shifts.group_by{|x| x.start.day}
	#@x=Location.count+1 # wrong... this gets all of them
	@locations=Location.find_all_by_area_id(@schedule.area_id)
	@x=@locations.size + 1
	@n_assigned=0
	@schedule.shifts.each{|x| @n_assigned+=1 if x.volunteer}
	
	@ppl_sh=@schedule.shifts.group_by{|v| v.volunteer}
	@ppl_sh.delete(nil)
	@ppl_sh_s=@ppl_sh.keys.sort_by{|x| [x.hat.to_s,x.name]}
	#@pp=@ppl_sh.keys.collect{|v| [v.name, v.shifts] if v!=nil}
	@tms=@schedule.getshifttimes
     #@vgroups = @sched2010.shifts.group_by {|shift| shift.volunteer} 
    respond_to do |format|
      format.html # show.html.erb 
     
      format.xml  { render :xml => @schedule }
    end
    
  end
    
  def print
	@schedule = Schedule.find(params[:id])
	if @schedule.start != @schedule.shifts[0].start then
	   #flash[:error]="wrong begin date"
	end
       
	@shift_days=@schedule.shifts.group_by{|x| x.start.day}
	#@x=Location.count+1 # wrong... this gets all of them
	@locations=Location.find_all_by_area_id(@schedule.area_id)
	@x=@locations.size + 1
	@n_assigned=0
	@schedule.shifts.each{|x| @n_assigned+=1 if x.volunteer}
	
	@ppl_sh=@schedule.shifts.group_by{|v| v.volunteer}
	@ppl_sh.delete(nil)
	@ppl_sh_s=@ppl_sh.keys.sort_by{|x| [x.hat.to_s,x.name]}
	#@pp=@ppl_sh.keys.collect{|v| v if v!=nil}
	@tms=@schedule.getshifttimes
     #@vgroups = @sched2010.shifts.group_by {|shift| shift.volunteer} 
	 
	 render(:layout => 'print')
 end
 def print2
	@schedule = Schedule.find(params[:id])
	if @schedule.start != @schedule.shifts[0].start then
	   #flash[:error]="wrong begin date"
	end
       
	@shift_days=@schedule.shifts.group_by{|x| x.start.day}
	#@x=Location.count+1 # wrong... this gets all of them
	@locations=Location.find_all_by_area_id(@schedule.area_id)
	@x=@locations.size + 1
	
	@n_assigned=0
	@schedule.shifts.each{|x| @n_assigned+=1 if x.volunteer}
	
	@ppl_sh=@schedule.shifts.group_by{|v| v.volunteer}
	@ppl_sh.delete(nil)
	@ppl_sh_s=@ppl_sh.keys.sort_by{|x| [x.hat.to_s,x.name]}
	#@pp=@ppl_sh.keys.collect{|v| v if v!=nil}
	@tms=@schedule.getshifttimes
     #@vgroups = @sched2010.shifts.group_by {|shift| shift.volunteer} 
	 
	 render(:layout => 'print')
  end
  def save
	@schedule = Schedule.find(params[:id])
	if @schedule.start != @schedule.shifts[0].start then
	   #flash[:error]="wrong begin date"
	end
       
	@shift_days=@schedule.shifts.group_by{|x| x.start.day}
	#@x=Location.count+1 # wrong... this gets all of them
	@locations=Location.find_all_by_area_id(@schedule.area_id)
	@x=@locations.size + 1
	@n_assigned=0
	@schedule.shifts.each{|x| @n_assigned+=1 if x.volunteer}
	
	@ppl_sh=@schedule.shifts.group_by{|v| v.volunteer}
	@ppl_sh.delete(nil)
	@ppl_sh_s=@ppl_sh.keys.sort_by{|x| [x.hat.to_s,x.name]}
	#@pp=@ppl_sh.keys.collect{|v| v if v!=nil}
	@tms=@schedule.getshifttimes
     #@vgroups = @sched2010.shifts.group_by {|shift| shift.volunteer} 
	 headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="BSParking2013-keys.xls"'
    headers['Cache-Control'] = ""

	 render(:layout => 'print')
 end
 def save2
	@schedule = Schedule.find(params[:id])
	if @schedule.start != @schedule.shifts[0].start then
	   #flash[:error]="wrong begin date"
	end
       
	@shift_days=@schedule.shifts.group_by{|x| x.start.day}
	#@x=Location.count+1 # wrong... this gets all of them
	@locations=Location.find_all_by_area_id(@schedule.area_id)
	@x=@locations.size + 1
	@n_assigned=0
	@schedule.shifts.each{|x| @n_assigned+=1 if x.volunteer}
	
	@ppl_sh=@schedule.shifts.group_by{|v| v.volunteer}
	@ppl_sh.delete(nil)
	@ppl_sh_s=@ppl_sh.keys.sort_by{|x| [x.hat.to_s,x.name]}
	#@pp=@ppl_sh.keys.collect{|v| v if v!=nil}
	@tms=@schedule.getshifttimes
     #@vgroups = @sched2010.shifts.group_by {|shift| shift.volunteer} 
	 headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="BSParking2013-keys.xls"'
    headers['Cache-Control'] = ""

	 render(:layout => 'print')
 end
  # GET /schedules/new
  # GET /schedules/new.xml
  def new
    @schedule = Schedule.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.xml
  def create
    @schedule = Schedule.new(params[:schedule])
	
    respond_to do |format|
      if @schedule.save
        flash[:notice] = 'Schedule was successfully created.'
        format.html { redirect_to(@schedule) }
        format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  
  # PUT /schedules/1
  # PUT /schedules/1.xml
  def update
    @schedule = Schedule.find(params[:id])
    
    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
	 expire_page :action => 'show', :id => params[:id]
        flash[:notice] = 'Schedule was successfully updated.'
        format.html { redirect_to(@schedule) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.xml
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to(schedules_url) }
      format.xml  { head :ok }
    end
  end
  
  def set_locations
	  @schedule=Schedule.find(params[:id])
	  @locations=@schedule.locations
	  if request.post?
		  nlist=params[:locations]
		  nlist.each do |x|
			  l=Location.find(x)
			  @schedule.add_location(l)
		  end
		  
	  end
	  
  end
  
  #GET schedules/assign/1 for the volunteer to assign; POST for the table
def assign
	
	#@schedule=Schedule.find_by_title(params[:schedule])
	@schedule=Schedule.find(params[:id])
	if @schedule.nil?
		flash[:notice]="No schedule by the name: " && params[:schedule]
		@schedule=Schedule.find(Schedule.all.size)
		return
	end
	if request.post?
		@volunteer = Volunteer.find(params[:vol])
	else
		@volunteer=Volunteer.find(session[:update_vol]) if session[:update_vol]
		@volunteer=nil if (@volunteer.area.nil?||(@volunteer.area.id != @schedule.area.id))
	end	
	
	#@volunteers = @schedule.area.volunteers	
	@volunteers=[]
	if @volunteer.nil? 
		@volunteer=@schedule.area.volunteers[0]||Volunteer.find(2)
	end
	session[:update_vol]=@volunteer
	@n_shifts=@volunteer.shifts.find_all{|x| x.schedule_id==@schedule.id}.size	
	
	@shift_days=@schedule.shifts.group_by{|x| x.start.day}
	#@x=Location.count+1 # wrong... this gets all of them
	@locations=Location.find_all_by_area_id(@schedule.area_id)
	@x=@locations.size + 1
	#@n_assigned= @schedule.shifts.find(:all, :conditions=>'volunteer_id').size
	@n_assigned= @schedule.shifts.where(:conditions=>'volunteer_id').size
	#
	# get signed up volunteers by year, get all volunteers in an area, find intersection. 
	# That will be the list of volunteers for that schedule.
	 vol_by_year=Signup.find_all_by_year(@schedule.year).map{|x| x.volunteer_id}
	 vol_by_area=@schedule.area.volunteers.map{|x| x.id}
	 vols=vol_by_year & vol_by_area
	#
	# get all shifts assigned so far in a schedule and group by volunteer_id
	 #assd=@schedule.shifts.find(:all, :conditions=>'volunteer_id').map{|x| [x.id, x.volunteer_id]}
	 assd=@schedule.shifts.where(:conditions=>'volunteer_id').map{|x| [x.id, x.volunteer_id]}
	 vol_shifts=assd.group_by{|a,b| b}
	 vols.each do |v|
		 @volunteers << Volunteer.find(v)
		 if !vol_shifts.keys.include?(v)
			 vol_shifts[v] = []
		 end
	 end
	 
	#
	# combine available volunteers with their names and hours
	#
	#@vol_info=[[Volunteer.find(2), Volunteer.find(vols[4]).name, 13, Volunteer.find(34).restrictions]]
	#@vol_info=vols.map{|x| [x,Volunteer.find(x).name,0, Volunteer.find(x).restrictions]}
	 @vol_info=vols.map{|x| [x,Volunteer.find(x).name,vol_shifts[x].size||0, Volunteer.find(x).restrictions]}
  end
  
  # called when assigning a shift by the button click
  def update_shift
    vol = Volunteer.find(params[:vol])
	sh = Shift.find(params[:id])
	
	dropped=""
	added=""
	if vol.nil? #case admin
	elsif sh.volunteer_id == params[:vol]
		logger.info("tested sh.volunteer_id == params[:vol]")
		vol.remove_shift(sh)
		sh.volunteer=nil
		dropped="Dropped "+vol.name
	  
	elsif sh.volunteer == vol
		logger.info("tested sh.volunteer == vol")
		vol.remove_shift(sh)
		sh.volunteer=nil
		dropped="Dropped "+vol.name

	else 
		if vol.shifts.map{|s| s.start}.include?(sh.start)
		
		flash[:bad_cells]=sh.id
		flash[:error] = "ERROR: Can not put ",vol.name," in two places at once"
		redirect_to :action => 'assign', :id => sh.schedule.id, :vol=> vol
		return
		end
		#errors.add(:id, "Can't add shift there") 
		if sh.volunteer
			dropped=" and dropped "+sh.volunteer.name
		end
		
        	vol.add_shift(sh) 
		added="Added "+vol.name
	end 
	
	
	
	vol.save
	sh.schedule.updated_at=Time.now
	sh.schedule.save
	if sh.schedule.status != 0 # log udpates if in review or final state but not draft
		log=added + dropped+" "+sh.start.strftime("%a%I%p")+" at "+sh.location.name
		comment = Comment.new(:entry=>log,:volunteer_id=>session[:volunteer_id])
		comment.save
	end
	expire_page :controller => 'schedules', :action => 'show', :id => sh.schedule.id
	redirect_to :action => 'assign', :id => sh.schedule.id, :vol=> vol
end

# called from the 
#GET schedules/1/duplicate
def duplicate
	   #flash[:notice] = params.keys << " values: " << params.values
	   
    @old = Schedule.find(params[:id])
    session[:cid]=@old.id
    
    @schedule = Schedule.new
    @schedule.area_id=@old.area_id
    @schedule.year=@old.year+1
    @schedule.shiftlength=@old.shiftlength
    days_in_year=365
    days_in_year=366 if (@old.start.year+1).modulo(4)==0
	days_in_year=364 # for 2013
    @schedule.start=@old.start+days_in_year
    @schedule.end=@old.end+days_in_year
    @schedule.title = "Copy of " <<@old.title
    @schedule.locations=@old.shifts.collect{|x| x.location}.uniq!
  end
   # POST /schedules
  # POST /schedules.xml
  #def copy
   # @schedule = Schedule.new(params[:schedule])
	
    #respond_to do |format|
     # if @schedule.save
      #  flash[:notice] = 'Schedule was successfully copied.'
       # format.html { redirect_to(@schedule) }
        #format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
     # else
      #  format.html { render :action => "new" }
      #  format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
  #    end
  #  end
 # end
  def copy
	   @schedule = Schedule.new(params[:schedule])
	   @old=Schedule.find(session[:cid])
	   session[:cid]=nil
	   @schedule.save
	   @vols=[]
	   @vols=@old.shifts.collect{|x| [x.id, x.volunteer_id]}
	   oldshifts=@old.shifts
	@schedule.shifts.each_with_index do |x,i| 
		if oldshifts[i]
		oldshifts[i].volunteer.add_shift(x) if oldshifts[i].volunteer
		end
	end
	@schedule.save
	@n_assigned=0
	@schedule.shifts.each{|x| @n_assigned+=1 if x.volunteer}
	#redirect_to :action => 'assign', :schedule => @schedule.title, :vol=> session[:update_vol]
	redirect_to (@schedule)
end
protected
 def authorize
 end
 
 
 end
