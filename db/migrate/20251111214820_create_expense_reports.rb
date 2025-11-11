class CreateExpenseReports < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_reports do |t|
      t.string :title
      t.string :category
      t.decimal :amount
      t.date :date
      t.text :description
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
