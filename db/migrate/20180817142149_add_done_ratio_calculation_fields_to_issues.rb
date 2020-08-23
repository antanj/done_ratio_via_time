# Licensed under GNU GPL 2.0
# Author: Tecforce
# Website: http://tecforce.ru

class AddDoneRatioCalculationFieldsToIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :done_ratio_calculation_type, :integer, default: 0,
                                                                null: false

    add_index :issues, :done_ratio_calculation_type
  end
end
