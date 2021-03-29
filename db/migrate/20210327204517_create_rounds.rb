class CreateRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :rounds do |t|
      t.integer :number, null: false
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
    add_index :rounds, [:number, :game_id], unique: true
  end
end
