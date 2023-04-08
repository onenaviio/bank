class HistoryOperation < ApplicationRecord
  enum operation_type: %i[transactions payments]

  belongs_to :account
  belongs_to :card, optional: true
  belongs_to :sender, class_name: "User", foreign_key: :sender_id

  validates :title, :payload, :processed_at, :operation_type, presence: true
end
