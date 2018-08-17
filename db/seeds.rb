User.create!(name:  "Admin",
  email: "dat@gmail.com",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end

  Category.create! name: "Categories", depth: 0
10.times do |n|
  Category.create! name: Faker::Book.genre, depth: 1, parent_id: 1
end

20.times do |n|
  Category.create! name: Faker::Book.genre, depth: 2, parent_id: rand(1..10)
end

20.times do |n|
  name = Faker::Name.name
  Author.create! name: name, description: Faker::Lorem.sentence(15)
end



5.times do |n|
  name = Faker::Name.name
  Publisher.create! name:name
end


books = []
70.times do |n|
  Book.create(name: Faker::Book.genre, category_id: rand(2..15), number: rand(10..27),  user_id: 1, author_id: rand(1..5) ,
  description: Faker::Lorem.sentence(4), publisher_id: rand(1..5),
    picture: File.open(File.join(Rails.root,"app/assets/images/#{rand(1..5)}.jpg")) )
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


