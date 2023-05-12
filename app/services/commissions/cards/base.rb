class Commissions::Cards::Base < AppService
  param :card, Types::Card

  with_payload_option
  option :external, default: -> { false }

  def call
    case service_rate.send("#{commission_type}_commission_type").to_sym
    when :percent
      commission_by_percent.round(1)      
    when :value
      commission_by_value
    end
  end

  private

  def commission_type
    raise NotImplementedError
  end

  def commission_by_percent
    payload_with_commission.to_f * service_rate.send("#{commission_type}_commission_value") / 100
  end

  def commission_by_value
    return 0.0 if payload_with_commission.zero?

    service_rate.send("#{commission_type}_commission_value").to_f
  end

  def commission_field
    @commission_field ||= "#{commission_type}_to_commission"
  end

  def payload_with_commission
    limit_with_payload = reached_limit.send(commission_field) + payload
    return 0.0 if limit_with_payload <= month_limit.send(commission_field)

    limit_with_payload - month_limit.send(commission_field)
  end

  def reached_limit
    @reached_limit ||= card.account.reached_limit
  end

  def month_limit
    @month_limit ||= card.account.month_limit
  end

  def service_rate
    @service_rate ||= card.account.service_rate
  end
end
