class AddProjectToLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :logs, :project_id, :integer
  end
end
