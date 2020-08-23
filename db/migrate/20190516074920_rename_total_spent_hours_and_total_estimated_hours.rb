# Licensed under GNU GPL 2.0
# Author: Tecforce
# Website: http://tecforce.ru

class RenameTotalSpentHoursAndTotalEstimatedHours < ActiveRecord::Migration[5.2]
  def change
    rename_column :issues, :total_estimated_hours, :total_estimated_time
    rename_column :issues, :total_spent_hours, :total_spent_time
  end
end
