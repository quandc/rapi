require "ohm"
require './lib/redic'
REDIS_CONFIG = YAML.load_file(Rails.root.join('config', 'redis.yml'))

# uri = URI.parse(REDIS_CONFIG[Rails.env]['redis_connection'])
# byebug
Ohm.redis = Redic.new(REDIS_CONFIG[Rails.env]['redis_connection'])
# $redis = Redis.new(host: uri.host,
#                              port: uri.port,
#                              password: uri.password,
#                              thread_safe: REDIS_CONFIG[Rails.env]['thread_safe'])

