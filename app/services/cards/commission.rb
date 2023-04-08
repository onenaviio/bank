class Cards::Commission < AppService
  def initialize(card)
    @card = card
  end

  def call
    {
      value: service_rate.c2c_commission_value.to_f,
      type: service_rate.c2c_commission_type.to_sym
    }
  end

  private

  attr_reader :card

  def service_rate
    @service_rate ||= card.service_rate
  end
end
