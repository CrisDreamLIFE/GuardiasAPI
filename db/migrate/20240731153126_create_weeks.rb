class CreateWeeks < ActiveRecord::Migration[7.1]
  def change
    create_table :weeks do |t|
      t.string :label
      t.date :start_date
      t.date :end_date
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
