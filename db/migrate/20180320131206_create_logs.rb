class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.integer :duration
      t.string :remarks
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
