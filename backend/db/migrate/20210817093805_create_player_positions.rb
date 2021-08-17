# frozen_string_literal: true

class CreatePlayerPositions < ActiveRecord::Migration[6.1]
  def change
    create_table :player_positions do |t|
      t.references :player, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true

      t.timestamps
    end

    add_index :player_positions, %i[player_id position_id], unique: true
  end
end
