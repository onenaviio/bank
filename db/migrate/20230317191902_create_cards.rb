class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false
      t.string :number, null: false
      t.date :expires_date, null: false
      t.string :cvv, null: false

      t.timestamps
    end
  end
end
