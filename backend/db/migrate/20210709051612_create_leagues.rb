# frozen_string_literal: true

class CreateLeagues < ActiveRecord::Migration[6.1]
  def change
    create_table :leagues do |t|
      t.string :name, null: false, limit: 100
      t.integer :country_number, null: false

      t.timestamps
    end

    add_index :leagues, :name, unique: true
  end
end
