class Card < ApplicationRecord
  belongs_to :account

  has_many :history_operations, dependent: :nullify

  validates :number, uniqueness: true
  validates :number, :expires_date, :cvv, presence: true
end
