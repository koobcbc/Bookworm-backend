# Basic Setup
Create rails app
```bash
rails new bookworm_app_api --api -d postgresql --skip-git
```

`cd temperatures_app_api` and Create database
```bash
rails db:create
```

# Generate Scaffolds and Create Schema
Create higher level model first (user hasmany books, so create user first)
```bash
rails g scaffold user nickname description profilePicture readingGoal:integer totalPageNum:integer
```

Create lower level model
```bash
rails g scaffold book title authors:string[] year publisher imageLinks:string[] pageNumber:integer description:text language categories:string[] canonicalVolumeLink starRating:decimal reviews:string[] notes:string[] quotes:string[]
```

Add Foreign Key To lower level model (books)
```bash
rails g migration AddForeignKeyToBooks
```

For the migration that includes adding data type of arrays, make it into this syntax
```ruby
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
```

## Add Foreign Key To Higher Level model (through migration file)
For the migration of adding foreign key to books, add the add_column line
```ruby
class AddForeignKeyToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :user_id, :integer
  end
end
```

```bash
rails db:migrate
```
The Schema has been created. Check the file

# Set up ActiveRecord Relations
**models/user.rb**
```ruby
class User < ApplicationRecord
    has_many :books
end
```

**models/book.rb**
```ruby
class Book < ApplicationRecord
    belongs_to :user
end
```








