class CreateServiceRates < ActiveRecord::Migration[6.1]
  def change
    create_table :service_rates do |t|
      t.string :title, null: false
      t.float :service_per_month, null: false, default: 0
      
      t.string :c2c_commission_type, null: false
      t.float :c2c_commission_value, null: false, default: 0

      t.timestamps
    end
  end
end
