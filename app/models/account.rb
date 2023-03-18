class Account < ApplicationRecord
  enum currency: %i[rub usd eur], _prefix: true

  belongs_to :user

  has_many :cards, dependent: :destroy
  has_many :history_operations, dependent: :destroy

  validates :number, :balance, presence: true
  validates :number, uniqueness: true
end
