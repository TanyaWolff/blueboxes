require 'my_lib.rb'

class HomeController < ApplicationController
  
  def index
    
     @count_2011 = Volunteer.where("tickets>0 and hat=='f'").size
     @keycount= Signup.find_all_by_year(Date.today.year)
     @sleeps_2011 = Date.new(2011,7,29) - Date.today 
     @sleeps_2012 = Date.new(2012,8,3) - Date.today
      
  end


 
 def getData
     @sched2010=Schedule.find_by_title("Parking2010")
     @allV = Volunteer.all
     @nShifts=@shifttimes.size
     #render(:file=>"c:\\temp\\schedule.csv")
     p=make_file
     #send_file("c:\\temp\\schedule.csv")
     render(:text=>p)
  end
  
  
  
 

  def timetable
    if request.post?
    		 logger.info("Params from timetable... "+params.to_s)
 	@shifts=params[:shift]
      Shift.update(params[:shift].keys, params[:shift].values)
    end
    @locations=Location.all
    @volunteers=Volunteer.all
  end
  
  def paste
    @message = "pasting "+params[:volunteer_id]
  end

  def add_vol_to_shift
  	@volunteer = Volunteer.find(params[:arg1])
  end

  def method_missing(name, *args)
 	render(:inline => %{
 		<h2>Unknown action: #{name} </h2>
 		<%= debug(params) %>
 	})
  end
  
  
  private
 def authorize
  end

  def next_volunteer
  end
 
 def initialize
 
  end

  
 
 def make_file
  cr="<br/>"
  @sched_file=','
    
    for t in @shifttimes
      @sched_file+=t.strftime("%a,")
    end
    @sched_file+=cr
    
    @sched_file+=","
    for t in @shifttimes
      @sched_file+=t.strftime("%l%P,")
    end
    @sched_file+=cr

    @allV.each do |v|
     vlocs = display_by_volunteer(v)
     @sched_file+=v.name
     @sched_file+=", "
     for loc in vlocs do
        @sched_file+=loc
        @sched_file+=","
     end
    @sched_file+=cr
    end
    
    @sched_file+=","
    for t in @shifttimes
      @sched_file+=t.strftime("%a,")
    end
    @sched_file+=cr
    
    @sched_file+=","
    for t in @shifttimes
      @sched_file+=t.strftime("%l%P,")
    end
    @sched_file+=cr

  @sched_file
  end #make_file

 def sched2010
    @sched2010 
  end
  def sched_file
    @sched_file 
  end

 
  
   def set_vol
    if request.post? 
 		 logger.info("Params from set_vol... "+params.to_s)
            
      @volunteer = Volunteer.find(params[:id])
      render (nil)
      #redirect_to :action => 'assign'
      # :schedule=>params[:schedule], :id=>params[:id]
    end
  end
  
end
