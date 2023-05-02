class Api::V1::Operations::Cards::Withdrawals < AppService
  # include HistoryOperationsConstants

  with_payload_option
  option :card, Types::Card

  def call
    ActiveRecord::Base.transaction do
      Operations::Accounts::Withdrawals.call(account: account, payload: payload)
    end
  end

  private

  def account
    @account ||= card.account
  end
end
