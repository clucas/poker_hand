class CreateWins < ActiveRecord::Migration[6.1]
  def change
    create_table :wins do |t|
      t.boolean :status, default: false
      t.string :rank, null: false
      t.references :round, null: false, foreign_key: true
      t.references :hand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
