class ChangeStartdateInLogs < ActiveRecord::Migration[5.1]
  def change
  	rename_column :logs, :startdate, :date
  end
end
