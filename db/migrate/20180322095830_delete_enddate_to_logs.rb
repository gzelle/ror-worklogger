class DeleteEnddateToLogs < ActiveRecord::Migration[5.1]
  def change
  	remove_column :logs, :enddate, :date
  end
end
