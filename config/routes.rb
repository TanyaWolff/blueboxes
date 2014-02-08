ActionController::Routing::Routes.draw do |map|
  map.resources :comments

  map.resources :signups

  map.resources :pictures

  map.resources :areas

  map.resources :schedules

  map.resources :locations
  
 
  
  map.resources :shifts
  map.connect "blueskies",:controller => "home"
  map.connect "prefs/",:controller => "prefs",:action => "index"

  map.connect 'volunteers/email', :controller => 'volunteers', :action => 'email'
  map.connect 'volunteers/prefs', :controller => 'volunteers', :action => 'prefs'
  map.resources :volunteers
  #map.connect "home/set_vol/:id/:schedule", :controller => 'home', :action=>'set_vol'
  #map.connect "home/assign/:schedule", :controller => 'home', :action => 'assign'
  map.connect "home/slotPerson2/", :controller => 'home', :action => 'slotPerson2'
  
  map.connect "home/slots/:schedule", :controller => 'home', :action => 'slots'
  map.connect "gate/duties", :controller => 'gate', :action => 'duties'
  map.connect "gate/duties", :controller => 'gate', :action => 'message'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  #map.dup 'schedules/:id/duplicate', :controller => 'home', :action=>'dup'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "blueskies"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  #map.connect "*anything",
  #            :controller => "home",
  #            :action => "index"
end
