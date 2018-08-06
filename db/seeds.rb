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

  Category.create! name: "Categories", left: 1, right: 10, depth: 0
  Category.create! name: "Sport", left: 2 , right: 3, depth: 1, parent_id: 1
  Category.create! name: "Romance", left: 4, right: 5, depth: 1, parent_id: 1
  Category.create! name: "Thriller", left: 6 , right: 7, depth: 1, parent_id: 1
  Category.create! name: "Science", left: 8 , right: 9, depth: 1, parent_id: 1

5.times do |n|
  name = Faker::Name.name
  Author.create! name: name, description: Faker::Lorem.sentence(15)
end



5.times do |n|
  name = Faker::Name.name
  Publisher.create! name:name
end


books = []
50.times do |n|
  Book.create(name: Faker::Book.genre, category_id: rand(2..4), number: rand(10..27),  user_id: 1, author_id: rand(1..5) ,
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


