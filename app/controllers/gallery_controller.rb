class GalleryController < ApplicationController
	before_filter :check_admin, :except => [:index,:get,:save,:picture,:show]
  caches_page  :show
  caches_page :index
  caches_action :picture
  def index
	 
	  @pics=Picture.all
  end

  def get
	  @picture = Picture.new
  end

  def save
	@picture = Picture.new(params[:picture])
	if @picture.save
		
		
		
		
		expire_page :controller => 'gallery', :action=>'index'
		 
		 if session[:edit_vol]
			 expire_action :controller => 'volunteers', :action=>'index'
			expire_action :controller => 'volunteers', :action => 'show', :id => session[:edit_vol]

			v=Volunteer.find(session[:edit_vol])
			v.update_attributes(:picture_id=>@picture.id)
			
			redirect_to(:controller => 'volunteers', :action=>'show', :id =>session[:edit_vol])
		else
		 redirect_to(:controller => 'gallery', :action=>'show', :id => @picture.id)

		end
	else
		  render(:action => :get)
	end
		  
  end
  def edit
	@picture = Picture.find(params[:id])  
  end
  
  def update
	 @picture=Picture.find(params[:id])
	 expire_page :action => 'show', :id=>params[:id]
	 expire_page :action => 'index'
	expire_action :controller => 'volunteers', :action => 'index'
	  
	 
	redirect_to(:action=>'show', :id => params[:id])
  end
  
  #def picture
#	  @picture = Picture.find(params[:id])
#	  send_data(@picture.data, :filename=>@picture.name, :type=>@picture.content_type, :disposition=> "inline")
  #end

  def show
	  @picture=Picture.find(params[:id])
	 
  end

end
private
 def test
	 
	  @picture = Picture.find(1)
	  send_data(@picture.data, :filename=>@picture.name, :type=>@picture.content_type, :disposition=> "inline")
  
  end
  