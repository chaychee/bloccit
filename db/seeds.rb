require 'faker'
 
# Create users
# Note: by calling `User.new` instead of `create`,
# we create an instance of User which isn't immediately saved to the database.

# The `skip_confirmation!` method sets the `confirmed_at` attribute
# to avoid triggering an confirmation email when the User is saved.

# The `save` method then saves this User to the database.
5.times do
  user = User.new(
    name:   Faker::Name.name,
    email:  Faker::Internet.email,
    password: Faker::Internet.password(10)
  )
  user.skip_confirmation!
  user.save!
end
users=User.all

# Create Topics
25.times do
  Topic.create!(
      name:   Faker::Lorem.sentence,
      description:  Faker::Lorem.paragraph
    )
end
topics=Topic.all


# Create Posts
750.times do
  Post.create!(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph,
    topic:  topics.sample
 )
end
posts = Post.all

# Create Comments
500.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: Faker::Lorem.paragraph
 )
end


user = User.find(1)
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Admin User',
  email: 'admin@jg.com',
  password: 'asdfasdf',
  role: 'admin'
)

user = User.find(2)
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Moderator User',
  email: 'moderator@jg.com',
  password: 'asdfasdf',
  role: 'moderator'
)

user = User.find(3)
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Member User',
  email: 'member@jg.com',
  password: 'asdfasdf'
)
 
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
 