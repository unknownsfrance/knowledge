# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_knowledge_session', 
                                                      expires_after: Time.now.getutc + 60*60*24*365*10
