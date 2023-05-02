class Card < ApplicationRecord
  belongs_to :account
  has_one :service_rate, through: :account

  validates :number, uniqueness: true
  validates :number, :expires_date, :cvv, presence: true

  def commission
    Types::Cards::Commission[{
      value: service_rate.c2c_commission_value.to_f,
      type: service_rate.c2c_commission_type.to_sym
    }]
  end
end
