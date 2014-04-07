class PollsUsers < ActiveRecord::Migration
  def change
    create_table :polls_users do |t|
      t.belongs_to :poll
      t.belongs_to :user
    end
  end
end
