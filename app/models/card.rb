class Card < ApplicationRecord
  belongs_to :account
  has_one :service_rate, through: :account

  has_many :history_operations, dependent: :nullify

  validates :number, uniqueness: true
  validates :number, :expires_date, :cvv, presence: true
  
  def commission
    Cards::Commission.call(self)
  end
end
