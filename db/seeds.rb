require "faker"

puts "Generating Fake Users...\n"

leslie = User.create(
  first_name: "Leslie", 
  last_name: "Knope", 
  email: "waffles_everyday@pawnee.gov", 
  password: "password"
)

ron = User.create(
  first_name: "Ron", 
  last_name: "Swanson", 
  email: "scotch_life@pawnee.gov", 
  password: "password"
)

10.times do 
  full_name = Faker::TvShows::ParksAndRec.character.split(" ")
  User.create(
    first_name: full_name.first,
    last_name: full_name.last,
    email: Faker::Internet.email,
    password: "password"
  )
end

puts "Generating Posts...\n"

leslie_post = Post.create(
  title: "An Ode to Anne Perkins",
  body: "Anne Perkins is an amazing human being and all around fantastic Unicorn.",
  author: leslie
)

ron_post = Post.create(
  title: "Why Scotch should be an official food group.",
  body: "Scotch is the essence of life. Lagavulin has increased my life span by at least 30%. This is a fact.",
  author: ron
)

50.times do 
  user = User.all.sample
  Post.create(
    author: user,
    title: Faker::Quote.famous_last_words,
    body: Faker::Lorem.paragraph_by_chars(number: 300)
  )
end

puts "Generating Comments for all Posts....\n"

Post.all.each do |post|
  rand(1..10).times do
    user = User.all.sample
    Comment.create(author: user, post: post, body: Faker::Movies::BackToTheFuture.quote)
  end
end

puts "Seed data complete!"