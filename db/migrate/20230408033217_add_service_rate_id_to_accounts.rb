class AddServiceRateIdToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_reference :accounts, :service_rate, null: false, foreign_key: true
  end
end
