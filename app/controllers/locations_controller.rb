class LocationsController < ApplicationController
	before_filter :check_admin, :except => [:show, :index]
  # GET /locations
  # GET /locations.xml
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])
    respond_to do |format|
      if @location.save
        create_shifts_for_location
        flash[:notice] = 'Location was successfully created.'
        format.html { redirect_to(@location) }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(@location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end
  private


    def add_shifts_for_location
      
    end  
    

    def create_shifts_for_location
      
      @shifttimes=getshifttimes
      @sched2010=Schedule.find_by_title("Parking2010")
      @shifttimes.each do |t|
        shift=Shift.new
        shift.location=@location
        shift.start=t
        @sched2010.shifts << shift
      end
      @sched2010.save
    end
    
    
 

  def find_schedule
    @sched2010=Schedule.find_by_title("Parking2010")
    if @sched2010 == nil then
      @sched2010 = Schedule.new
      @sched2010.title = "Parking2010"
      @sched2010.save
      create_shifts_for_location
    end
    @sched2010
  end

end
