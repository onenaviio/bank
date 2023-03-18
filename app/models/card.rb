class Card < ApplicationRecord
  belongs_to :account

  validates :number, uniqueness: true

  validates :number, :expires_date, :cvv, presence: true
end
