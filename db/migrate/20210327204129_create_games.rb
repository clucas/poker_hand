class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.integer :players_count
      t.integer :rounds_count

      t.timestamps
    end
    add_index :games, :name, unique: true
  end
end
