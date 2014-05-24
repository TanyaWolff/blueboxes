Blueboxes::Application.routes.draw do

  resources :comments
  resources :signups
  resources :pictures
  resources :areas
  resources :schedules
  resources :locations
  resources :shifts
  get 'volunteers/email' => 'volunteers#email'
  resources :volunteers
  get 'prefs' => 'prefs#index'
  get 'volunteers/prefs' => 'volunteers#prefs'
  match 'volunteers/edit_pw/:id' => 'volunteers#edit_pw'
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
  match 'admin/set_area/:id' => 'admin#set_area'
  match 'admin/unset_area' => 'admin#unset_area'
  get 'admin/profile' => 'admin#profile'
  get 'gallery' => 'gallery#index'
  get 'gallery/picture/:id' => 'gallery#picture'
  get 'schedules/duplicate/:id' => 'schedules#duplicate'
  match 'schedules/assign/:id' => 'schedules#assign'
  get 'schedules/print/:id' => 'schedules#print'
  get 'schedules/save/:id' => 'schedules#save'
  get 'schedules/save2/:id' => 'schedules#save2'
  get 'schedules/print2/:id' => 'schedules#print2'
  match 'schedules/update_shift/:id/:vol' => 'schedules#update_shift'
  match 'schedules/do_work/:id' => 'schedules#do_work'
  match 'schedules/do_jswork/:id' => 'schedules#do_jswork'
  match 'news' => 'news#index'
  match 'news/new_entry' => 'news#new_entry'


  #map.connect "home/assign/:schedule", :controller => 'home', :action => 'assign'
  #map.connect "gate/duties", :controller => 'gate', :action => 'duties'

  root :to => 'areas#index'

  # See how all your routes lay out with "rake routes"

end
