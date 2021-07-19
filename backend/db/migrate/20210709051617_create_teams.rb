# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.references :league, null: false, foreign_key: true, index: false
      t.string :name, null: false, limit: 100

      t.timestamps
    end

    add_index :teams, %i[league_id name], unique: true
  end
end
