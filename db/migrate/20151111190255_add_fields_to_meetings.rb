class AddFieldsToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :accepted, :boolean, default: false
    add_column :meetings, :note, :text
  end
end
