class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :authors, array: true, default: []
      t.string :year
      t.string :publisher
      t.string :imageLinks, array: true, default: []
      t.integer :pageNumber
      t.text :description
      t.string :language
      t.string :categories, array: true, default: []
      t.string :canonicalVolumeLink
      t.decimal :starRating
      t.string :reviews, array: true, default: []
      t.string :notes, array: true, default: []
      t.string :quotes, array: true, default: []

      t.timestamps
    end
  end
end
