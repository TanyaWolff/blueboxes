# BlueBoxes
===========
### Welcome to **BlueBoxes**, the BlueSkies volunteer scheduling application. 
+ We sort *hats* and *keys* and interesting ideas. 
+ We have green food and blue bins. 
+ We share rides to the bridge, the beer store and **Blue Skies**. 
+ We help our neighbours. 
+ We return carts. 
+ We make musicians feel honoured to fly halfway around the world to sleep in a tent and have cold showers. 
+ We love outhouses, camping, and water.
+ We revere the outhouse volunteers. 
+ We revere the parking volunteers who park cars the **Blue Skies Way** into tight spaces so day visitors only have to walk 2 kilometers instead of 4. 
+ We rise early and do yoga. 
+ We jam late into the night. 
+ We park, we listen, we play, we reuse, we share. 
+ We love Magoo, Tilston, Oskar and all BlueSkies organizers
+ We love **BlueSkies**

### We are **BlueBoxes**! 

# Setup
=======

1. Clone the repo https://github.com/TanyaWolff/blueboxes.git
2. Enter "rake db:setup" to create and load the schema on a new development db and seed it with initial data in db/seeds.rb. To seed only, do "rake db:seed"
3. If creating a schedule for a new area other than parking, 
a) Login as admin/admin
b) Create the new area
c) Create new locations for the area, and assign the area to each location
d) Create new schedule with begin and end dates (July 31, 2014 - Aug 4, 2014), Name, Area, then save.


## Notes
=======
db:create creates the database
db:drop deletes the database
db:schema:load creates tables and columns within the (existing) database following schema.rb
db:setup does db:create, db:schema:load, db:seed
db:reset does db:drop, db:setup

# Launch
========
To start the server with the application running on port 3001, do
"rails s -p 3001". To launch in detached mode so you can exit the shell
and still have it running, use -d. To run in production mode, use -e production.
My process is running under ruby 1.9.3 
/home/pi/.rvm/rubies/ruby-1.9.3-p484/bin/ruby script/rails s -d -p 3001

# Scratch
=========
If starting from scratch, you need ruby, rails, sqlite3, rvm, ruby-gems
The Gemfile has the versions of the packages you need. 

Prerequisite: Install rvm and the ruby interpreter

Switch to desired ruby version and create a gemset. The rails3 gemset is my stepping stone from 2.3.5 to 4.0
$ rvm list 
(list should include ruby-1.9.3-p484)
$ rvm use 1.9.3-p484
$ rvm gemset create rails3

Add bundler to install the gems and dependencies in the Gemfile.
$ gem install bundler -v '1.0.0'
$ bundle -v
(shows I have 1.5.3)
Go to your project directory where the Gemfile is located.
$ cd ~/blueboxes
$ bundle install --without production
(creates .bundle/config so that future calls to bundle install won't require --without production)
Note you can alternatively add bundler to Gemfile, but I opted for the simplest
Gemfile since adding dependencies upon dependencies grew a huge can of worms.

Show versions of gems in environment:
$ rvm 1.9.3@rails3 do gem list
list includes sqlite3 (1.3.8), sqlite3-ruby (1.3.3), rails (3.2.17)

Always call rake within bundle context
$ rvm exec rake

Gemfiles are nice!
They allow different projects to run with different ruby versions. 
This is handy for upgrading to ruby 2.1 and rails 4.0 (my dream).
When switching to a directory with a gemfile, rvm switches to the correct ruby.
Notice I don't have ruby in my gemfile, but rvm switches to the default, set at 1.9.3-p484.
