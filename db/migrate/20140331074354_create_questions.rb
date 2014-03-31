class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :votes
      t.string :name
      t.references :poll, index: true

      t.timestamps
    end
  end
end
