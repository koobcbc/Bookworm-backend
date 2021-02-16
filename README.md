# Basic Setup
Create rails app
```bash
rails new bookworm_app_api --api -d postgresql --skip-git
```

If you want to remove the app for some reason.
```
rm -rf bookworm_app_api
```

`cd bookworm_app_api` and Create database
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
rails g scaffold book googleBooksId title starRating:decimal reviews:string[] notes:string[] quotes:string[] user_id:integer
```

### THIS CAN BE SKIPPED IF YOU ADDED FOREIGN KEYS (user_id in this case) ALREADY WHEN YOU GENERATED SCAFFOLDS
-----------
Add Foreign Key To lower level model (books)
```bash
rails g migration AddForeignKeyToBooks
```
----------

For the migration that includes adding data type of arrays, make it into this syntax (in app/db/migrate/[files])
```ruby
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
```

```ruby
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

```
-----------

## Add Foreign Key To Higher Level model (through migration file) CAN BE SKIPPED since user_id is added in the previous migration
For the migration of adding foreign key to books, add the add_column line
```ruby
class AddForeignKeyToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :user_id, :integer
  end
end
```
----------

```bash
rails db:migrate
```
The Schema has been created. Check the file

# Set up ActiveRecord Relations
**models/user.rb**
```ruby
class User < ApplicationRecord
    has_secure_password
    has_one :profile
    has_many :books
end
```

**models/profile.rb**
```ruby
class Profile < ApplicationRecord
    belongs_to :user
end
```

**models/book.rb**
```ruby
class Book < ApplicationRecord
    belongs_to :user
end
```

# Create a seedfile

`rails c` and in the console,
```bash
user = User.new( username: 'katy', password: 'katypw1')
user.save
```

**config/routes.rb**
Add a login route

```ruby
Rails.application.routes.draw do
  resources :books
  resources :profiles

  resources :users do                                                            
    collection do                                                                
      post '/login', to: 'users#login'                                            
    end                                                                          
  end       
                                
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

**app/controller/users_controller.rb**
Add the following code to add the login action in the controller

```ruby
def login
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      render json: {status: 200, user: user}
    else
      render json: {status: 401, message: "Unauthorized"}
    end
end
```

Try POST in postman
POST in `http://localhost:3000/users/login`
- user[username]
- user[password]

Successful match will give status code 200.
If unauthorized, it will give status code 401.

# Tokens

```ruby
gem 'jwt'
gem 'dotenv-rails'
```
- To generate and decode JSON Web Tokens on our Rails server.
- To set Environment Variables for use in our JSON Web Tokens.

run `bundle`

## Generate a JWT
We are generating JWT for the users so that they can be kept in 'stateless session'

**users_controller.rb**
Add this method under private.
It will return a hash that will contain the payload including the user's id and username encrypted:

```ruby
  def payload(id, username)
    {
      exp: (Time.now + 30.minutes).to_i,
      iat: Time.now.to_i,
      iss: ENV['JWT_ISSUER'],
      user: {
        id: id,
        username: username
      }
    }
  end
```

Also under private in users_controller.rb, write a method that will create the token with the payload

```ruby
def create_token(id, username)
  JWT.encode(payload(id, username), ENV['JWT_SECRET'], 'HS256')
end
```
### ENV variables

In the root of the repository (ex. bookworm_app_api)
```bash
touch .env
touch .gitignore
```

Add `.env` to .gitignore file

In your **.env** file, add the following code

```ruby
JWT_SECRET=whateversecretyouwant
JWT_ISSUER=whoeveryouwant
```

## Generate a Token
In the login route in **users_controller.rb**, write the following code in order to create a token (Full code of the method is below)
This will send a token to our user when they authenticate
```ruby
  token = create_token(user.id, user.username)
```
This can be included in the following code
```ruby
  def login                                                                        
    user = User.find_by(username: params[:user][:username])                        
    if user && user.authenticate(params[:user][:password])                         
      token = create_token(user.id, user.username)                                 
      render json: { status: 200, token: token, user: user }                       
    else                                                                           
      render json: { status: 401, message: "Unauthorized" }                        
    end                                                                            
  end 
```

# ACCESS: AUTHENTICATE ROUTES
## Authentication methods

Let's write a method that is available to all of our controllers that will authenticate the JWT, and tell us if the user is allowed.

+ Currently logged in user (get_current_user method in appication_controller.rb)

**app/controllers/application_controller.rb**
```ruby
  class ApplicationController < ActionController::API
                                                                
  def authenticate_token
        # puts "AUTHENTICATE JWT"
        render json: { status: 401, message: 'Unauthorized' } unless decode_token(bearer_token)
    end
  
    def bearer_token
        # puts "BEARER TOKEN"
        header = request.env["HTTP_AUTHORIZATION"]

        pattern = /^Bearer /
        # puts "TOKEN WITHOUT BEARER"
        header.gsub(pattern, '') if header && header.match(pattern)
    end
  
    def decode_token(token_input)
        # puts "DECODE TOKEN, token input: #{token_input}"
        # token = 
        JWT.decode(token_input, ENV['JWT_SECRET'], true)
        # render json: { decoded: token }
    rescue
        render json: { status: 401, message: 'Unauthorized' }                          
    end

    def get_current_user 
        return if !bearer_token   
        decoded_jwt = decode_token(bearer_token) 
        User.find(decoded_jwt[0]["user"]["id"])
    end

end 
```

## Currently logged in user

**app/controllers/users_controller.rb**
In the show route, add,
```ruby
def show
  render json: get_current_user
end
```

## Authorization

In **application_controller.rb** under private
```ruby
def authorize_user
  render json: { status: 401, message: "Unauthorized" } unless get_current_user.id == params[:id].to_i       
end
```

In **users_controller.rb** on the top, add the following line

```ruby
  before_action :authorize_user, except: [:login, :create, :index]
```
- Create a second user in Rails console
```bash
User.create( username: 'Gollum', password: 'Gollum' )
```

**app/users_controllers.rb**
```ruby
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :authenticate_token, except: [:login, :create]

    ...
    ...
  end
```

**db/migrate/seeds.rb**
```ruby
Profile.create([
  { 
    nickname: "Katy",
    description: "College Student who likes to read fiction novel",
    profilePicture: "https://lumiere-a.akamaihd.net/v1/images/c94eed56a5e84479a2939c9172434567c0147d4f.jpeg?region=0,0,600,600",
    readingGoal: 10,
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
        ],
        notes: ["The characters are going through very average, every day events--they don't get into these crazy, ridiculous situations that you see in some other novels of this genre"],
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
        ],
        notes: [
            "p.36",
            "p.100"
        ],
        quotes: [
            "Beauty is rarely soft or consolatory. Quite the contrary. Genuine beauty is always quite alarming.",
            "I suppose at one time in my life I might have had any number of stories, but now there is no other. This is the only story I will ever be able to tell."
        ],
        user_id: 1
    },
    {
        isbn: "9780140283297",
        title: "On the Road",
        starRating: 3.5,
        reviews: [
            "An authentic work of art . . . the most beautifully executed, the clearest and the most important utterance yet made by the generation Kerouac himself named years ago as 'beat,' and whose principal avatar he is.",
            "Kerouac turned up the temperature in American letters, and it's never gone down since."
        ],
        notes: [
            "p.20",
            "p.70",
            "p.130"
        ],
        quotes: [],
        user_id: 1
    },
    {
        isbn: "9780743273565",
        title: "The Great Gatsby",
        starRating: 4.0,
        reviews: [
            "A true classic of twentieth-century literature"
        ],
        notes: [
        ],
        quotes: ["I hope she'll be a fool -- that's the best thing a girl can be in this world, a beautiful little fool"],
        user_id: 1
    }
])
```







