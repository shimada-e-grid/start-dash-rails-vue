# frozen_string_literal: true

class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.string :name, null: false, limit: 50
      t.string :short_name, null: false, limit: 10

      t.timestamps
    end

    add_index :positions, :name, unique: true
    add_index :positions, :short_name, unique: true
  end
end
