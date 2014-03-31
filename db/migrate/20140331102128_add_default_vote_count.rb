class AddDefaultVoteCount < ActiveRecord::Migration
  def up
    change_column_default :questions, :votes, 0
  end

  def down
    change_column_default :questions, :votes, nil
  end
end
