class Operations::Payment < AppService
  # include HistoryOperationsConstants

  with_payload_option
  option :account, Types::Account

  def call
    ActiveRecord::Base.transaction do
      decrease_account_balance!
      perform_payment!
    end
  end

  private

  def decrease_account_balance!
    Operations::Accounts::Withdrawals.call(account: account, payload: payload)
  end

  def perform_payment!
    {}
  end
end
