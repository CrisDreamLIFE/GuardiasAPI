class AddNumberAndYearToWeeks < ActiveRecord::Migration[7.1]
  def change
    add_column :weeks, :number, :integer
    add_column :weeks, :year, :integer
  end
end
