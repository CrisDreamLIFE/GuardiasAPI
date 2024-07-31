class CreateBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :blocks do |t|
      t.time :time
      t.references :day, null: false, foreign_key: true
      t.references :engineer, null: true, foreign_key: true

      t.timestamps
    end
  end
end
