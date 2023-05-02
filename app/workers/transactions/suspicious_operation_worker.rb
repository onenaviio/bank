class Transactions::SuspiciousOperationWorker < ApplicationWorker
  sidekiq_options queue: "suspicious", retry: 0

  def perform(transaction_id); end
end
