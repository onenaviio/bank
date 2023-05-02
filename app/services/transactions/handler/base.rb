class Transactions::Handler::Base < AppService
  param :transaction

  private

  def confirm_transaction!
    transaction.confirm!
  end

  def account_from
    @account_from ||= transaction.account_from
  end

  def account_to
    @account_to ||= transaction.account_to
  end

  def card_from
    @card_from ||= transaction.card_from
  end

  def card_to
    @card_to ||= transaction.card_to
  end
end
