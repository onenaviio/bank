require "sidekiq/web"

redis_url = ENV.fetch("REDIS_URL", "redis://localhost:6379")

Sidekiq.configure_server do |config|
  config.redis = { url: "#{redis_url}/12" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{redis_url}/12" }
end

# Sidekiq.default_worker_options = { backtrace: 20, retry: 2 }
