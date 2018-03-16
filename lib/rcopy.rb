require "rcopy/version"
require 'redis'

module Rcopy
  class Copier
    def initialize(source_redis)
      @source_redis = source_redis
    end

    def copy_to(destination_redis)
      destination_redis.multi do 
        destination_redis.flushdb
        @source_redis.keys.each do |k|
          ttl = @source_redis.pttl(k)
          ttl = 0 if (ttl == -1)
          destination_redis.restore(k, ttl, @source_redis.dump(k))
        end
      end
    end
  end
end
