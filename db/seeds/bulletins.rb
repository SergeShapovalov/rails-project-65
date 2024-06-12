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
