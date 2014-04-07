class AddRequireLoginToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :require_login, :boolean, default: false, null: false
  end
end
