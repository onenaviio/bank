class CreateHistoryOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :history_operations do |t|
      t.references :account, null: false, foreign_key: { on_delete: :cascade }
      t.references :card, null: true, foreign_key: true

      t.string :title, null: false
      t.float :payload, null: false
      t.datetime :processed_at, null: false

      t.integer :operation_type, null: false
    end

    add_column :history_operations, :options, :jsonb, default: {}
  end
end
