require 'json'

# one-to-one mapping of schedule to worker
# the worker has the same id as the schedule it's working for
class Worker
	attr_accessor :tasks
	attr_accessor :id
	def initialize(sched,user)
	 @id=sched
	 @tasks=[]
 	 @author=user
	end

	def do_work
puts "doing work ***"	
	puts @tasks
	puts "***"
	mytasks=JSON.parse(@tasks)
	 mytasks["tasks"].each do |t|
		puts t.to_s
		puts "shift: "+t["shift"].to_s
		puts "volunteer: "+t["volunteer"].to_s
		do_task(t["shift"],t["volunteer"])
	 end
	 @tasks=[]
	end
	def do_task(shift,volunteer)
		puts "**** do shift "+shift.to_s()
		sh=Shift.find(shift)
		vol=Volunteer.find_by_name(volunteer)
          	@schedule=sh.schedule
        	dropped=""
		added=""
		if !sh.volunteer_id.nil?
		puts "DEBUG: look for sh.volid=vol "
		puts "sh.volid: "+sh.volunteer_id.to_s
		puts "vol.id: "+vol.id.to_s
		end
		if vol.nil? #case admin
		
		elsif sh.volunteer_id == vol.id
		  puts "dropping shift ********"
                  vol.remove_shift(sh)
                  sh.volunteer=nil
                  dropped="Dropped "+vol.name

        	else
		  puts "adding shift ********"
                  if vol.shifts.map{|s| s.start}.include?(sh.start)
			  #flash[:bad_cells]=sh.id
			  #flash[:error] = "ERROR: Can not put ",vol.name," in two places at once"
			  return
                  end
                  if sh.volunteer
                        dropped=" and dropped "+sh.volunteer.name
                  end

                  vol.add_shift(sh)
                  added="Added "+vol.name
		end
		vol.save
		mysched=sh.schedule
		mysched.updated_at=Time.now
		mysched.save
		# log udpates if in review or final state but not draft
		if mysched.status != 0 
			log=added + dropped+" "+sh.start.localtime.strftime("%a%I%p")+" at "+sh.location.name
			comment = Comment.new(:entry=>log,:volunteer_id=>@author)
			comment.save
		end
		puts "Completed updates to schedule"
   	end
	def add_task(task)
		@tasks << task
	end
end

