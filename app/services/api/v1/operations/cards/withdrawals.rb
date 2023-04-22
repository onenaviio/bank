class Api::V1::Operations::Cards::Withdrawals < AppService
  include HistoryOperationsConstants

  with_payload_option
  option :card, Types::Card

  def call
    ActiveRecord::Base.transaction do
      Operations::Accounts::Withdrawals.call(account: account, payload: payload)

      HistoryOperations::Create.call(
        card: card,
        account: account,
        payload: payload,
        title: WITHDRAWALS_TITLE,
        operation_type: :payments
      )
      # TODO: add options (место, банкомат и тп)
    end
  end

  private

  def account
    @account ||= card.account
  end
end
