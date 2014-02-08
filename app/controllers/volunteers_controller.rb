class VolunteersController < ApplicationController
	before_filter :check_admin, :except => [:show, :index, :prefs, :edit_pw, :edit, :update]
	#caches_action :index #uncomment when not debugging
	caches_action :show 
  # GET /volunteers
  # GET /volunteers.xml
  def index
	 if session[:area]
		@volunteers = Volunteer.find_all_by_area_id(session[:area], :order => 'hat desc, key desc, last_name')
		#v=Signup.find_all_by_year(2012).map{|s| s.volunteer}.sort_by{|x| x.last_name}.uniq
		#@volunteers=v.group_by{|a| a.area_id}[session[:area]]
	else 
		@volunteers = Volunteer.find(:all, :order => 'hat desc, key desc, last_name')
	end
	@sum_tix_adult=@volunteers.sum{|v| v.tickets||0}
	@sum_tix_student=@volunteers.sum{|v| v.tix_students||0}
	@sum_tix_child=@volunteers.sum{|v| v.tix_kids||0}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @volunteers }
    end
  end
  def email
@emails='nobody here'
	 if session[:area]
	  #@emails=Volunteer.find_all_by_area_id(session[:area]).map{|v| v.email+", " if v.email}
	@emails=Schedule.find_last_by_area_id(session[:area]).shifts.find(:all, :conditions=>'volunteer_id').map{|v| v.volunteer}.uniq.map{|v| v.email+", " if v.email}
	else
	@emails=Volunteer.find(:all).map{|v| v.email+", " if v.email}
	end
  end
 
  def prefs
	
  @volunteers = Volunteer.find(:all, :order => 'hat desc, key desc, last_name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @volunteers }
    end
  end
  # GET /volunteers/1
  # GET /volunteers/1.xml
  def show
	  
    @volunteer = Volunteer.find(params[:id])
    if @volunteer.picture_id
	@picture=Picture.find(@volunteer.picture_id)
    else
    	@picture=nil
    end
    session[:edit_vol]=nil
    #n=@volunteer.last_name+@volunteer.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @volunteer }
    end
  end

  # GET /volunteers/new
  # GET /volunteers/new.xml
  def new
    @volunteer = Volunteer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @volunteer }
    end
  end

  # GET /volunteers/1/edit
  def edit
    @volunteer = Volunteer.find(params[:id])
    
    unless @volunteer.id==session[:volunteer_id]||session[:isHat]
      flash[:notice] = "Must be hat to change other volunteers"
      redirect_to url_for(:controller => 'admin', :action=>'index')
      return
    end
    
     session[:edit_vol]=@volunteer.id
  end

  # POST /volunteers
  # POST /volunteers.xml
  def create
    @volunteer = Volunteer.new(params[:volunteer])

    respond_to do |format|
      if @volunteer.save
        flash[:notice] = 'Volunteer was successfully created.'
        format.html { redirect_to(@volunteer) }
        format.xml  { render :xml => @volunteer, :status => :created, :location => @volunteer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @volunteer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.xml
  def update
    @volunteer = Volunteer.find(params[:id])
    unless @volunteer.id==session[:volunteer_id]||session[:isHat]
      flash[:notice] = "Must be hat to change other volunteers"
      redirect_to url_for(:controller => 'admin', :action=>'index')
      return
    end
    respond_to do |format|
      if @volunteer.update_attributes(params[:volunteer])
	       expire_page :controller =>'gallery', :action => 'show', :id=>@volunteer.picture_id
	       expire_action :controller => 'volunteers', :action => 'show', :id => params[:id]
	      
	       expire_action :action => 'index'
        flash[:notice] = 'Volunteer was successfully updated.'
        format.html { redirect_to(@volunteer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit_pw" }
        format.xml  { render :xml => @volunteer.errors, :status => :unprocessable_entity }
      end
    end
  end
  def schedule
	  
    @volunteer = Volunteer.find(params[:id])
    
    redirect_to :controller => 'parking', :action => 'slotPerson2', :id=>@volunteer
  end

  def edit_pw
     @volunteer = Volunteer.find(params[:id])
     unless @volunteer.id==session[:volunteer_id]||session[:isHat]
      flash[:notice] = "Must be hat to change another pw"
      redirect_to url_for(:controller => 'admin', :action=>'index')
      return
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.xml
  def destroy
    @volunteer = Volunteer.find(params[:id])
    @volunteer.destroy

    respond_to do |format|
      format.html { redirect_to(volunteers_url) }
      format.xml  { head :ok }
    end
  end
  def print_list
	 
    unless session[:isHat]
      flash[:notice] = "Must be hat to print all info"
      redirect_to url_for(:controller => 'admin', :action=>'index')
      return
    end
      if session[:area]
		#@volunteers = Volunteer.find_all_by_area_id(session[:area], :order => 'hat desc, key desc, last_name')
		v=Signup.find_all_by_year(2013).map{|s| s.volunteer}.sort_by{|x| x.last_name}.uniq
		@volunteers=v.group_by{|a| a.area_id}[session[:area]]
		@area=Area.find(session[:area]).name
	else 
		@volunteers = Volunteer.find(:all, :order => 'hat desc, key desc, last_name')
	end
	@sum_tix_adult=@volunteers.sum{|v| v.tickets||0}
	@sum_tix_student=@volunteers.sum{|v| v.tix_students||0}
	@sum_tix_child=@volunteers.sum{|v| v.tix_kids||0}
    #headers['Content-Type'] = "application/vnd.ms-excel"
    #headers['Content-Disposition'] = 'attachment; filename="invoice_list.xls"'
    #headers['Cache-Control'] = ""
    
    render(:layout => 'print')
  end

end
