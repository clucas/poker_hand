class CreateHands < ActiveRecord::Migration[6.1]
  def change
    create_table :hands do |t|
      t.integer :number, null: false
      t.string :card_list, null: false
      t.references :player, null: false, foreign_key: true
      t.references :round, null: false, foreign_key: true

      t.timestamps
    end
  end
end
