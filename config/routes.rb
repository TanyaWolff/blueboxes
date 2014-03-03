Blueboxes::Application.routes.draw do

  resources :comments
  resources :signups
  resources :pictures
  resources :areas
  resources :schedules
  resources :locations
  resources :shifts
  resources :volunteers
  get 'prefs' => 'prefs#index'
  get 'volunteers/email' => 'volunteers#email'
  get 'volunteers/prefs' => 'volunteers#prefs'
  get 'home/set_vol/:id/:schedule' => 'home#set_vol'
  get 'home/slotPerson2' => 'home#slotPerson2'
  get 'home/slots/:schedule' => 'home#slots'
  get 'gate/duties' => 'gate#message'
  get 'admin/index' => 'admin#index'
  get 'admin/login' => 'admin#login'
  get 'admin/logout' => 'admin#logout'
  get 'admin/bkup' => 'admin#bkup'
  get 'admin/stats' => 'admin#stats'
  get 'admin/set_area' => 'admin#unset_area'
  get 'admin/profile' => 'admin#profile'

  #map.connect "home/assign/:schedule", :controller => 'home', :action => 'assign'
  #map.connect "gate/duties", :controller => 'gate', :action => 'duties'

  root :to => 'areas#index'

  # See how all your routes lay out with "rake routes"

end
