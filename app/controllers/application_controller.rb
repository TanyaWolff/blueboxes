# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => [:login]
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def availdays(av)
    avail_day_1=false
    avail_day_1=true if (av&1)==1
  end
  def isHat
    return (Volunteer.find(session[:volunteer_id]).hat) 
  end 
  def getshifttimes
    first_slot = DateTime.new(y=2010,m=7,d=29, h=18,min=00,s=00)
    thurs_hrs = [16,18,20]
    fri_hrs = [8,10,12,14,16,18,20]
    mon_hrs = [9,11,13]
    slots = {:thurs => [], :fri => [], :sat => [], :sun => [], :mon => []}
    for t in thurs_hrs do slots[:thurs] << DateTime.new(y=2010,m=7,d=29, h=t,min=00,s=00) end
    for t in fri_hrs do 
      slots[:fri] << DateTime.new(y=2010,m=7,d=30, h=t,min=00,s=00)
      slots[:sat] << DateTime.new(y=2010,m=7,d=31, h=t,min=00,s=00)
      slots[:sun] << DateTime.new(y=2010,m=8,d=1, h=t,min=00,s=00)
    end
    for t in mon_hrs do 
      slots[:mon] << DateTime.new(y=2010,m=8,d=2, h=t,min=00,s=00) 
    end

    shifttimes_a=slots.collect{|x| x[1]}
    shifttimes=[]

    shifttimes_a.each do |x|
    shifttimes+=x
    end
    shifttimes.sort!
    shifttimes
  end   
protected
def authorize
	
    unless Volunteer.find_by_id(session[:volunteer_id])
      flash[:notice] = "Please log in"
      redirect_to url_for(:controller => 'admin', :action=>'login')
    end
   
  end
  
  def check_admin
     unless session[:isHat]
      flash[:notice] = "Must be hat to perform this task."
      redirect_to url_for(:controller => 'admin', :action=>'index')
     end
  end

end
