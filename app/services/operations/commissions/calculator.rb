class Operations::Commissions::Calculator < AppService
  def initialize(payload:, commission:)
    @payload    = payload.abs.to_f
    # {
    #   value: 0.5
    #   type: :percent
    # }
    # or
    # {
    #   value: 100,
    #   type: :value
    # }
    @commission = commission
  end

  def call
    {
      payload: round(payload),
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
    case commission[:type]
    when :percent
      payload * (1.0 + commission[:value] / 100)
    when :value
      payload + commission[:value] 
    end
  end
end
