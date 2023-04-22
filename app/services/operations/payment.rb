class Operations::Payment < AppService
  include HistoryOperationsConstants

  with_payload_option
  option :account, Types::Account

  def call
    ActiveRecord::Base.transaction do
      decrease_account_balance!
      payment_options = perform_payment!
      history_operation_create!(payment_options)
    end
  end

  private

  def decrease_account_balance!
    Operations::Accounts::Withdrawals.call(account: account, payload: payload)
  end

  def perform_payment!
    {}
  end

  def history_operation_create!(options)
    HistoryOperations::Create.call(
      account: account,
      payload: payload,
      title: PAYMENT_TITLE,
      operation_type: :payments,
      options: options
    )
  end
end
