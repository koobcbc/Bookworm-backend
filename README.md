rails new bookworm_app_api --api -d postgresql --skip-git
rails db:create
rails g scaffold user nickname description profilePicture readingGoal:integer totalPageNum:integer
rails g scaffold book title authors:string[] year publisher imageLinks:string[] pageNumber:integer description:text language categories:string[] canonicalVolumeLink starRating:decimal reviews:string[] notes:string[] quotes:string[]
rails g migration AddForeignKeyToBooks
rails db:migrate


