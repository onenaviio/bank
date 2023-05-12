class Card < ApplicationRecord
  belongs_to :account

  validates :number, uniqueness: true
  validates :number, :expires_date, :cvv, presence: true

  def commission_for_send(payload, external: false)
    Commissions::Cards::Send.call(self, payload: payload, external: external)
  end

  def commission_for_withdrawals(payload, external: false)
    Commissions::Cards::Withdrawals.call(self, payload: payload, external: external)
  end
end
