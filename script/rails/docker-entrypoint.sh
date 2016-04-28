#!/bin/bash
set -e
rm -rf /app/shared/tmp/sockets/unicorn.sock /app/shared/tmp/pids/unicorn.pid
bundle exec rake db:drop db:create db:migrate db:seed
bundle exec rails s -p 3000 -b '0.0.0.0'