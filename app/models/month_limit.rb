class MonthLimit < ApplicationRecord
  belongs_to :service_rate

  validates  :withdrawals_to_commission,
             :c2c_external_to_commission,
             :c2c_internal_to_commission,
             :sbp_to_commission,
             presence: true
end
