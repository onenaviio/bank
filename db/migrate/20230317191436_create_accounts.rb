class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string :number, null: false
      t.integer :currency, null: false
      t.float :balance, default: 0, null: false

      t.timestamps
    end
  end
end
