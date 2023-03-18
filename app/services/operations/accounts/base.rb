class Operations::Accounts::Base < AppService
  include Operations::Errors

  def initialize(account:, payload:)
    @account = account
    @payload = payload.abs.to_f
  end

  private

  def round(value)
    value.floor(2)
  end

  attr_reader :account, :payload
end
