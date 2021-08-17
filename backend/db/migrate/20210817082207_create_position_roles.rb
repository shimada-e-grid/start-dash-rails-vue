# frozen_string_literal: true

class CreatePositionRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :position_roles do |t|
      t.references :position, null: false, foreign_key: true
      t.string :name, null: false, limit: 50
      t.string :short_name, null: false, limit: 10

      t.timestamps
    end

    add_index :position_roles, :name, unique: true
    add_index :position_roles, :short_name, unique: true
  end
end
