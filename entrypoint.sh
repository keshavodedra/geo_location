#!/bin/bash
set -e
# Remove a potentially pre-existing server.pid for Rails.
rm -f /geo-location-app/tmp/pids/server.pid
RAILS_ENV=development rake db:create
RAILS_ENV=development bundle exec rails server -b 0.0.0.0 -e development