# :nocov:
class Operations::Accounts::Base < AppService
  include Operations::Errors

  with_payload_option
  option :account, Types::Account

  private

  def round(value)
    value.round(2)
  end

  attr_reader :account, :payload
end
