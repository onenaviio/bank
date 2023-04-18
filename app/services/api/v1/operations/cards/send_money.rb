class Api::V1::Operations::Cards::SendMoney < AppService
  def initialize(card_from:, card_to:, payload:, commission:)
    @card_from  = card_from
    @card_to    = card_to
    @payload    = payload
    @commission = commission
  end

  def call
    Operations::Sending::Account2Account.call(
      account_from: card_from.account,
      account_to: card_to.account,
      payloads: payloads
    )
  end

  private

  attr_reader :card_from, :card_to, :payload, :commission

  def payloads
    Operations::Commissions::Calculator.call(payload: payload, commission: commission)
  end
end
