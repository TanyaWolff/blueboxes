class GateController < ApplicationController
  def index
	  @message="Placeholder for hat messages"
  end

  def message
	  @message="Placeholder for hat messages"
  end

  def gatekeepers
	  @volunteers=Volunteer.find_all_by_area_id(session[:area], :order => 'hat desc, key desc, last_name')
  end

  def duties
	  @duties=Location.find_all_by_area_id(session[:area])
  end

end
