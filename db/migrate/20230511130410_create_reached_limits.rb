class CreateReachedLimits < ActiveRecord::Migration[6.1]
  def change
    create_table :reached_limits do |t|
      t.references :account, null: false, foreign_key: true

      t.float :withdrawals_to_commission, null: false, default: 0.0

      t.float :c2c_external_to_commission, null: false, default: 0.0
      t.float :c2c_internal_to_commission, null: false, default: 0.0
      t.float :sbp_to_commission, null: false, default: 0.0
    end
  end
end
