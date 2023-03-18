class Operations::Accounts::Base < AppService
  def initialize(account:, payload:)
    @account = account
    @payload = payload.abs.to_f
  end

  private

  attr_reader :account, :payload
end
