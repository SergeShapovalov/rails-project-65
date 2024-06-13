# frozen_string_literal: true

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
