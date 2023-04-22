class Api::V1::Operations::Cards::SendMoney < AppService
  with_payload_option
  option :card_from, Types::Card
  option :card_to, Types::Card
  option :commission, Types::Cards::Commission

  def call
    Operations::Sending::Account2Account.call(
      account_from: card_from.account,
      account_to: card_to.account,
      payloads: payloads
    )
  end

  private

  def payloads
    Operations::Commissions::Calculator.call(payload: payload, commission: commission)
  end
end
