module RedisHelper
  def clear
    $redis.multi do |multi|
      keys = $redis.keys '*'
      $redis.flushdb
    end
  end
end