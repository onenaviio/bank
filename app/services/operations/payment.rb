class Operations::Payment < AppService
  include HistoryOperationsConstants

  def initialize(account:, payload:)
    @account = account
    @payload = payload.abs
  end

  def call
    ActiveRecord::Base.transaction do
      decrease_account_balance!
      pay_options = perform_payment!
      history_operation_create!(pay_options)
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

  attr_reader :account, :payload
end
