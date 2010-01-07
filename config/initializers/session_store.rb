# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_functional_testing_session',
  :secret      => '1dc4732a89563e4e9f59fb0e583551af2103c4b4d79a14da585b3779938ffec3308c4cb1f9896e5313740f8e2254056daeb2e4f1987d58383023130c0d89c2a0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
