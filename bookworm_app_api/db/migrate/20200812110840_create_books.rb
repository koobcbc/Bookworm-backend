class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :googleBooksId
      t.string :title
      t.decimal :starRating
      t.string :reviews, array: true, default: []
      t.string :notes, array: true, default: []
      t.string :quotes, array: true, default: []
      t.integer :user_id

      t.timestamps
    end
  end
end
