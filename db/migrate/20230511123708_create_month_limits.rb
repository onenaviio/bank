class CreateMonthLimits < ActiveRecord::Migration[6.1]
  def change
    create_table :month_limits do |t|
      t.references :service_rate, null: false, foreign_key: true

      t.float :withdrawals_to_commission, null: false

      t.float :c2c_external_to_commission, null: false
      t.float :c2c_internal_to_commission, null: false
      t.float :sbp_to_commission, null: false
    end
  end
end
