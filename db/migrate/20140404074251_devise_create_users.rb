class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email, null: false, default: ''

      ## Rememberable
      t.datetime :remember_created_at

      ## Omniauthable
      t.string :provider
      t.string :uid

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
