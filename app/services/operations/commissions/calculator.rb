class Operations::Commissions::Calculator < AppService
  def initialize(payload:, commission: 0)
    @payload    = payload.to_f
    @commission = commission.to_f
  end

  def call
    {
      payload: payload,
      commission_payload: round(payload_with_commission - payload),
      payload_with_commission: round(payload_with_commission)
    }
  end

  private

  attr_reader :payload, :commission

  def round(value)
    value.ceil(2)
  end

  def payload_with_commission
    payload * (1.0 + commission / 100)
  end
end
