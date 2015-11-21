class CreateJoinTableAlleyMeeting < ActiveRecord::Migration
  def change
    create_join_table :alleys, :meetings do |t|
      # t.index [:alley_id, :meeting_id]
      # t.index [:meeting_id, :alley_id]
    end
  end
end
