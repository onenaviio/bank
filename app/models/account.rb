class Account < ApplicationRecord
  enum currency: %i[rub usd eur], _prefix: true

  belongs_to :user
  belongs_to :service_rate

  has_many :cards, dependent: :destroy

  has_many :transactions_from, dependent: :nullify, class_name: "Transaction", foreign_key: :account_from_id
  has_many :transactions_to, dependent: :nullify, class_name: "Transaction", foreign_key: :account_to_id

  has_one :reached_limit
  has_one :month_limit, through: :service_rate

  validates :number, :balance, presence: true
  validates :number, uniqueness: true
end
