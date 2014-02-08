class NewsController < ApplicationController
  def index
    @comments=Comment.all(:order => 'created_at DESC')
    if session[:volunteer_id]
      @volunteer=Volunteer.find(session[:volunteer_id])
    end
    @comment = Comment.new
      @sleeps_2011 = Date.new(2011,7,29) - Date.today 
      @sleeps_2012 = Date.new(2012,8,3) - Date.today 
  end
  def new_entry
      @volunteer=Volunteer.find(session[:volunteer_id])
      newcom = params[:entry]
      @comment = Comment.new(params[:comment])
      @comment.volunteer_id=session[:volunteer_id]
      if @comment.save
         flash[:notice] = "Thank you for your valuable comment"
      else
         flash[:notice] = "Error adding comment"
	end
      redirect_to(:controller=>'news')
   
  end
  def show
    render :action => params[:page]
  end

  protected
    def authorize
    end


end
