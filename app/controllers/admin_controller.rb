class AdminController < ApplicationController
  def login
    if request.post?
      volunteer = Volunteer.authenticate(params[:name], params[:password])
      if volunteer 
        session[:volunteer_id] = volunteer.id
	session[:update_vol] = volunteer.id
        session[:isHat] = volunteer.hat
        uri=session[:orig_uri]
        session[:orig_uri]=nil
	session[:area] = nil
        redirect_to(uri || {:action=>'index'})
      else
        flash[:notice] = "Invalid username/password "
	  
        redirect_to(:controller=>'home',:action=>'index')

      end
    end
  end
 
  def logout
      session[:volunteer_id]=nil
      session[:isHat]=false
      session[:update_vol] =nil
      flash[:notice]="Logged out"
      redirect_to(:controller=>'home',:action=>'index')
  end
 def bkup
	 @d= Date.today.to_s
      @db_bs=@d + "blueskies.sqlite3"
      @db_camp=@d + "camp.sqlite3"
      @db_wed=@d + "wedding.sqlite3"
      @result=%x[bkup.bat #{@db_bs} #{@db_camp} #{@db_wed}]
  end

 def stats
      @signups=Signup.find_all_by_year(Date.today.year).group_by{|v| v.volunteer.area_id}
	  
	unless @signups.size > 0
      flash[:notice] = "No one has signed up yet"
      redirect_to url_for(:controller => 'admin')
    end
	
  end
  def set_area
	area=Area.find(params[:id])
	if !area.nil?
	session[:area] = area.id 
	else
	session[:area] = nil
	end
	redirect_to(:controller => :areas, :action => :show, :id => area.id )
  end
  def unset_area
	session[:area] = nil
	redirect_to(:controller => :admin, :action => :index )
  end
  def index
    @nvolunteers=Volunteer.count
     @areas = Area.all
    
    @signups=Signup.find_all_by_year(2012).group_by{|v| v.volunteer.area_id}
    @n_parking=@signups[1].size
    @n_gate=@signups[2].size
	
	
  end

  def profile
  end
  
  
end

