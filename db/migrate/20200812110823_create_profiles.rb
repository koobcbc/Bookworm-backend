class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :nickname
      t.string :description
      t.string :profilePicture
      t.integer :readingGoal
      t.integer :totalPageNum
      t.integer :user_id

      t.timestamps
    end
  end
end
