class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :description
      t.string :profilePicture
      t.integer :readingGoal
      t.integer :totalPageNum

      t.timestamps
    end
  end
end
