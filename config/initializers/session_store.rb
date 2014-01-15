# Be sure to restart your server when you modify this file.

Outtrippin::Application.config.session_store :cookie_store, key: '_outtrippin_session', domain: '.outtrippin.com' if Rails.env.production?
Outtrippin::Application.config.session_store :cookie_store, key: '_outtrippin_session' if Rails.env.development?