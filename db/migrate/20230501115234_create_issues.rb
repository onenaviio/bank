class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.string :message, null: false
      t.datetime :occured_at, null: false
      t.boolean :resolved, default: false
      t.text :code
    end

    add_column :issues, :context, :jsonb, default: {}
    add_column :issues, :backtrace, :jsonb, default: []
  end
end
