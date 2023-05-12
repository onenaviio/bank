class Commissions::Cards::Withdrawals < Commissions::Cards::Base
  private

  def commission_type
    :withdrawals
  end
end
