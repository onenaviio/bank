class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :account_from, null: false, index: true, foreign_key: { to_table: :accounts }
      t.references :account_to, null: true, index: true, foreign_key: { to_table: :accounts }

      t.references :card_from, null: true, index: true, foreign_key: { to_table: :cards }
      t.references :card_to, null: true, index: true, foreign_key: { to_table: :cards }

      t.string :external_account_to_id, null: true
      t.string :external_account_to_type, null: true

      t.string :operation_type, null: false
      t.float :payload, null: false
      t.float :commission_payload, null: false, default: 0.0
      t.string :comment, null: true
      t.datetime :started_at, null: false
      t.datetime :processed_at, null: true
      t.datetime :failed_at, null: true
      t.string :status, null: false
      t.boolean :suspicious, null: false, default: false
    end

    add_column :transactions, :extra_data, :jsonb, default: {}
  end
end
