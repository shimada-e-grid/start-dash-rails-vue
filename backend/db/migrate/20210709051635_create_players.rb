# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :team, null: true, foreign_key: true, index: false
      t.string :name, null: false, limit: 100
      t.date :birthday, null: false
      t.integer :uniform_number, null: false
      t.integer :country_number, null: false

      t.timestamps
    end

    add_index :players, %i[team_id uniform_number], unique: true
  end
end
