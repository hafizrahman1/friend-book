# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Friendship.delete_all
Post.delete_all
Comment.delete_all
Like.delete_all
Tag.delete_all
TAGS = ["adventurous","amused", "angry", "bad", "beautiful", "better", "charming", "cheerful", "creepy", "cute", "dangerous", "delightful", "depressed", "elegant", "energetic", "enthusiastic", "fancy", "friendly", "funny", "glorious", "gorgeous", "grumpy", "handsome", "happy", "hilarious", "hilarious","successful", "super", "tired", "tough"]

User.create!(
  name: "Hafiz",
  email: "hafiz@gmail.com",
  password: "password"
  )

User.create!(
  name: "Parm",
  email: "parm@gmail.com",
  password: "password"
  )

User.create!(
  name: "Wen",
  email: "wen@gmail.com",
  password: "password"
  )

100.times do |n|
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    last_sign_in_at: Time.now
    )
  user.save
end

# Posts
users = User.order(:created_at)
10.times do 
  users.each do |user|
    content = Faker::Hipster.sentence
    user.posts.create!(content: content)
  end
end

TAGS.each{|tag| Tag.create(:name  => tag)}
