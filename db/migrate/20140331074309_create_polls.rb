class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title

      t.timestamps
    end
  end
end
