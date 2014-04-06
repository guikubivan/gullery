# Be sure to restart your server when you modify this file.

#Gullery::Application.config.session_store :cookie_store, key: '_gullery_session'

#config.action_controller.session = {
#  :session_key => '_app_session',
#  :secret      => '3c9a9ee9a412932113153ef594aaf44ae0aa966086038f3c34834af92d09ef1b504b953da4a768cd86d5ca3536c276fcb5ddf6cd462ab801be1f9ad489f0aca6'
#}


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
Gullery::Application.config.session_store :active_record_store, {
  key: "_gullery_session",
  #domain: ".isp.com",
  expire_after: 24.hours,
}
