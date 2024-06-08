# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

[
  'Real Estate',
  'Transportation',
  'Services',
  'Home and Garden',
  'Personal belongings',
  'Business and Services'
].each do |name|
  Category.create!(name:)
end

3.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    admin: Faker::Boolean.boolean(true_ratio: 0.2)
  )
end

User.find_or_create_by(email: 'projectv.scorpion@gmail.com') do |user|
  user.name ||= 'Sergey Shapovalov'
  user.admin = 1
end

users = User.all
categories = Category.all
states = Bulletin.aasm.states.map(&:name)
images = (1..5).to_a.map do |number|
  Rails.root.join("test/fixtures/files/food_#{number}.jpg").open
end

50.times do
  bulletin = Bulletin.build(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph_by_chars(number: 200),
    category: categories.sample,
    user: users.sample,
    state: states.sample
  )

  bulletin.image.attach(io: File.open(images.sample), filename: 'food.jpg')
  bulletin.save!

  sleep 0.1
end
