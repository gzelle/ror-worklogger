class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.integer :duration
      t.string :remarks
      t.date :startdate
      t.date :enddate
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
