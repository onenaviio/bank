class Transactions::OperationWorker < ApplicationWorker
  sidekiq_options queue: "transactions", retry: 0

  def perform(transaction_id)
    transaction = Transaction.find(transaction_id)

    handling_service(transaction).call(transaction)
  rescue StandardError => e
    Issues::Creator.call(e, transaction_id: transaction_id)
    transaction&.fail!
  end

  private

  def handling_service(transaction)
    "Transactions::Handler::#{transaction.operation_type.capitalize}".constantize
  end
end
