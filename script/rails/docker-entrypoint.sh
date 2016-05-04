#!/bin/bash
set -e
apt-get install -y netcat
rm -rf /app/shared/tmp/sockets/unicorn.sock /app/shared/tmp/pids/unicorn.pid
bundle exec rake db:drop db:create db:migrate db:seed

APP_NAME="api"
APP_ROOT="/app"
ENV="development"
ls /app/config/unicorn/development.rb
# environment settings
export PATH="/usr/local/bundle/bin:/usr/local/bin:$PATH"
PID="$APP_ROOT/shared/pids/unicorn.pid"
OLD_PID="$PID.oldbin"

# sig () {
#   test -s "$PID" && kill -$1 `cat $PID`
# }

# oldsig () {
#   test -s $OLD_PID && kill -$1 `cat $OLD_PID`
# }
# sig 0 && echo >&2 "Already running" && exit 0
echo "Stalling for Elasticsearch"
# while true; do
#     nc -q 1 postgres 5432 2>/dev/null && break
# done
while true; do
    nc -q 1 redis 6379 2>/dev/null && break
done
echo "Starting $APP_NAME"
bundle exec unicorn -c ${APP_ROOT}/config/unicorn/development.rb -E $ENV
#"$CMD"
