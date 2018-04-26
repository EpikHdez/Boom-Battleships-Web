class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :score, null: false, default: 0
      t.integer :destroyed_ships, null: false, default: 0
      t.integer :lost_ships, null: false, default: 0
      t.boolean :turn, default: true
      t.boolean :finished, default: false
      t.boolean :victory
      t.boolean :board_set, default: false
      t.json :board
      t.integer :game_number, null: false
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :rival, null: false

      t.timestamps
    end

    add_foreign_key :matches, :users, column: :rival_id
  end
end
