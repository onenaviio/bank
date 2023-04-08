class Api::V1::Operations::Cards::Replenishment < AppService
  include HistoryOperationsConstants

  def initialize(card:, payload:)
    @card    = card
    @account = card.account
    @payload = payload.abs.to_f
  end

  def call
    ActiveRecord::Base.transaction do
      Operations::Accounts::Replenishment.call(account: account, payload: payload)

      HistoryOperations::Create.call(
        card: card,
        account: account,
        payload: payload,
        title: REPLENISHMENT_TITLE,
        operation_type: :payments
      )
      # TODO: add options (место, банкомат и тп)
    end
  end

  private

  attr_reader :card, :account, :payload
end
