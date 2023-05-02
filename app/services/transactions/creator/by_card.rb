class Transactions::Creator::ByCard < Transactions::Creator
  option :card_from, Types::Card
  option :card_to, Types::Card

  private

  def account_from
    @account_from ||= card_from.account
  end

  def account_to
    @account_to ||= card_to.account
  end

  def transaction_by
    :card
  end
end
