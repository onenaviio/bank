class Transactions::Creator::ByAccount < Transactions::Creator
  option :account_from, Types::Account
  option :account_to, Types::Account

  private

  def card_from; end

  def card_to; end

  def transaction_by
    :account
  end
end
