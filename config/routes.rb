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
  match 'volunteers/edit_pw' => 'volunteers#edit_pw'
  match 'volunteers/print_list' => 'volunteers#print_list'
  match 'home/set_vol/:id/:schedule' => 'home#set_vol'
  get 'home/slotPerson2' => 'home#slotPerson2'
  get 'home/slots/:schedule' => 'home#slots'
  get 'gate/duties' => 'gate#message'
  get 'admin/index' => 'admin#index'
  match 'admin/login' => 'admin#login'
  match 'admin/logout' => 'admin#logout'
  get 'admin/bkup' => 'admin#bkup'
  get 'admin/stats' => 'admin#stats'
  match 'admin/set_area' => 'admin#unset_area'
  get 'admin/profile' => 'admin#profile'
  get 'gallery' => 'gallery#index'
  get 'gallery/pictures/:id' => 'pictures#show'

  #map.connect "home/assign/:schedule", :controller => 'home', :action => 'assign'
  #map.connect "gate/duties", :controller => 'gate', :action => 'duties'

  root :to => 'areas#index'

  # See how all your routes lay out with "rake routes"

end
