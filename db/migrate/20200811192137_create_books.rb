class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string[] :authors array: true, default: []
      t.string :year
      t.string :publisher
      t.string[] :imageLinks
      t.integer :pageNumber
      t.text :description
      t.string :language
      t.string[] :categories
      t.string :canonicalVolumeLink
      t.decimal :starRating
      t.string[] :reviews
      t.string[] :notes
      t.string[] :quotes

      t.timestamps
    end
  end
end
