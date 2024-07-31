class AddStartTimeAndEndTimeToBlocks < ActiveRecord::Migration[7.1]
  def change
    add_column :blocks, :start_time, :datetime
    add_column :blocks, :end_time, :datetime
    remove_column :blocks, :time, :string
  end
end
