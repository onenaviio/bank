class Operations::Commissions::Calculator < AppService
  with_payload_option
  option :commission, Types::Commission

  def call
    Types::Commissions::Payload[{
      payload: round(payload),
      commission_payload: round(payload_with_commission - payload),
      payload_with_commission: round(payload_with_commission)
    }]
  end

  private

  def round(value)
    value.round(2)
  end

  def payload_with_commission
    case commission.type
    when :percent
      payload * (1.0 + (commission.value / 100))
    when :value
      payload + commission.value
    end
  end
end
