class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
