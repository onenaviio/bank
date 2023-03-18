class Operations::Cards::Base < AppService
  include Operations::Errors

  def initialize(card:, payload:)
    @account = card.account
    @payload = payload.abs.to_f
  end

  private

  attr_reader :payload, :account
end
