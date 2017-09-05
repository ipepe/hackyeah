# https://www.phusionpassenger.com/library/config/nginx/action_cable_integration/
require ::File.expand_path('../../config/environment', __FILE__)
Rails.application.eager_load!

run ActionCable.server