# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Profile.create([
  { 
    nickname: "Katy",
    description: "College Student who likes to read fiction novel",
    profilePicture: "https://lumiere-a.akamaihd.net/v1/images/c94eed56a5e84479a2939c9172434567c0147d4f.jpeg?region=0,0,600,600",
    readingGoal: 10,
    totalPageNum: 780,
    user_id: 1
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