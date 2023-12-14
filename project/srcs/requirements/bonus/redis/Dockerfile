FROM alpine:3.18.3

RUN apk update && apk upgrade && \
    apk add --no-cache redis && \
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g"  /etc/redis.conf && \
    sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g"  /etc/redis.conf && \
    echo "maxmemory-policy allkeys-lru" >> /etc/redis.conf

EXPOSE 6379

CMD [ "redis-server" , "/etc/redis.conf" ]

#These commands will install the Redis server on your system and configure it to use a maximum  of memory. 
#The "maxmemory" directive sets the maximum amount of memory that Redis is allowed to use. 
#The "maxmemory-policy" directive specifies the policy that Redis should use when the maximum memory limit has been reached 
#the "allkeys-lru" policy will cause Redis to remove the least recently used keys in order to free up memory.
