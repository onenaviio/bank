class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :patronymic, null: false

      t.string :phone, null: false

      t.string :email, null: false
      t.string :password, null: false
      
      t.date :birthday, null: false

      t.timestamps
    end
  end
end
