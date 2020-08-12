# Basic Setup
Create rails app
```bash
rails new bookworm_app_api --api -d postgresql --skip-git
```

If you want to remove the app for some reason.
```
rm -rf bookworm_app_api
```

`cd temperatures_app_api` and Create database
```bash
rails db:create
```

# Generate Scaffolds and Create Schema
### Create authentication model
```bash
rails g scaffold user username password_digest
```
### add `has_secure_password` Active Method Model
**app/models/user.rb**
```ruby
class User < ApplicationRecord
    has_secure_password
end
```
This is for setting and authenticating against a BCrypt password.
To use has_secure_password, password_digest column must be provided and include the bcrypt gem.

### use bcrypt gem
Uncomment the line `gem 'bcrypt', '~> 3.1.7'` in the Gemfile
Run `bundle`

### Perform Migration
```bash
rails db:migrate
```

**Authentication will continue after creating other models**

# Create Other Models
Create higher level model first (user hasmany books, so create user first)
```bash
rails g scaffold profile nickname description profilePicture readingGoal:integer totalPageNum:integer user_id:integer
```

Create lower level model
```bash
rails g scaffold book googleBooksId starRating:decimal reviews:string[] notes:string[] quotes:string[] user_id:integer
```

## THIS CAN BE SKIPPED IF YOU ADDED FOREIGN KEYS (user_id in this case) ALREADY WHEN YOU GENERATED SCAFFOLDS
-----------
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
-----------

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

# Create a seedfile

**db/migrate/seeds.rb**
```ruby
Profile.create([
  { 
    nickname: "Katy"
    description: "College Student who likes to read fiction novel"
    profilePicture: "https://lumiere-a.akamaihd.net/v1/images/c94eed56a5e84479a2939c9172434567c0147d4f.jpeg?region=0,0,600,600"
    readingGoal: 10
    totalPageNum: 780
  }
])


Book.create([
    {
        isbn: "9780307700414", 
        title: "Girls in White Dresses", 
        starRating: 3.5, 
        reviews: [
            "After reading this book, I had one of my first pangs of Kindle regret since purchasing the device a little over a year ago. Girls in White Dresses is the type of book that I wish I could drop in the mail to one of my college roommates, with explicit instructions to pass it on to the next lady in our little cluster after finishing."
        ]
        notes: ["The characters are going through very average, every day events--they don't get into these crazy, ridiculous situations that you see in some other novels of this genre"]
        quotes: [
            "Sometimes she missed people before they even left her, got depressed about a vacation being over before it started.",
            "In college, twenty-nine had seemed impossibly old. By now, she'd thought, she'd be married and have kids. But as each year went by, she didn't feel much different than she had before. Time kept going by and she was just here, the same.",
            "The thing is that you don't meet someone until you do ... and the older we get, the harder it is. And maybe not all of us will meet someone."
        ],
        user_id: 1
    },
    {
        isbn: "9781400031702",
        title: "The Secret History",
        starRating: 3,
        reviews: [
            "An accomplished psychological thriller. . . . Absolutely chilling. . . . Tartt has a stunning command of the lyrical.",
            "A huge, mesmerizing, galloping read, pleasurably devoured. . . . .Gorgeously written, relentlessly erudite."
        ]
        notes: [
            "p.36"
            "p.100"
        ]
        quotes: [
            "Beauty is rarely soft or consolatory. Quite the contrary. Genuine beauty is always quite alarming.",
            "I suppose at one time in my life I might have had any number of stories, but now there is no other. This is the only story I will ever be able to tell."
        ],
        user_id: 1
    }
    {
        isbn: "9780140283297"
        title: "On the Road"
        starRating: 3.5,
        reviews: [
            "An authentic work of art . . . the most beautifully executed, the clearest and the most important utterance yet made by the generation Kerouac himself named years ago as 'beat,' and whose principal avatar he is.",
            "Kerouac turned up the temperature in American letters, and it's never gone down since."
        ]
        notes: [
            "p.20",
            "p.70",
            "p.130"
        ],
        quotes: [],
        user_id: 1
    }
])
```







