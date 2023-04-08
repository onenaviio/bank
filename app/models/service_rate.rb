class ServiceRate < ApplicationRecord
  include ApplicationConstants

  enum c2c_commission_type: COMMISSION_TYPES.zip(COMMISSION_TYPES).to_h, _prefix: true

  validates :title, :service_per_month, :c2c_commission_value, :c2c_commission_type, presence: true
end
