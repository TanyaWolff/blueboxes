# Be sure to restart your server when you modify this file.
Blueboxes::Application.config.session_store :cookie_store, key: '_blueboxes_session'


# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
#ActionController::Base.session = {
#  :key         => '_blueskies_session',
#  :secret      => 'ed078dfd140a59626275fe63d54613214b0c726e0715b41633e00c2154839ff0c4204be060390af845db424683f7a04a8a91c1073e2942104a5893b15c7769fc'
#}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#ActionController::Base.session_store = :active_record_store
