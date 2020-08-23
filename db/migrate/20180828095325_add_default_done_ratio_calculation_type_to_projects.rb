# Licensed under GNU GPL 2.0
# Author: Tecforce
# Website: http://tecforce.ru

class AddDefaultDoneRatioCalculationTypeToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :default_done_ratio_calculation_type, :integer
  end
end
