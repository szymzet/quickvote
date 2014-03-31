class AddDefaultVoteCount < ActiveRecord::Migration
  def change
    change_column_default :questions, :votes, 0
  end
end
