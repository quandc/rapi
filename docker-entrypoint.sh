#!/bin/bash
set -e
rm -rf /app/shared/tmp/sockets/unicorn.sock /app/shared/tmp/pids/unicorn.pid
#bundle exec rake db:drop db:create db:migrate db:seed
APP_NAME="api"
APP_ROOT="/app"
ENV="development"
# environment settings
export PATH="/usr/local/bundle/bin:/usr/local/bin:$PATH"
CMD="unicorn -c config/unicorn/development.rb"
PID="$APP_ROOT/shared/pids/unicorn.pid"
OLD_PID="$PID.oldbin"
CMD="bundle exec unicorn -c config/unicorn/development.rb"

"$CMD"
# sig () {
#   test -s "$PID" && kill -$1 `cat $PID`
# }

# oldsig () {
#   test -s $OLD_PID && kill -$1 `cat $OLD_PID`
# }
# sig 0 && echo >&2 "Already running" && exit 0
#echo "Starting $APP_NAME"
"$CMD"
