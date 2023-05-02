class ApplicationWorker
  include Sidekiq::Worker

  def perform(_)
    raise NotImplementedError
  end

  protected

  def queue
    @queue ||= Sidekiq::Queue.new(sidekiq_options_hash["queue"])
  end
end
