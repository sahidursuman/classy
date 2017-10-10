puts "Creating admin account"
User.create! email: "admin@gmail.com",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  role: :admin,
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.zone.now

puts "Creating moderator account"
User.create! email: "moderator@gmail.com",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  role: :moderator,
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.zone.now

puts "Creating normal users"
10.times.each do |i|
  User.create! email: "member#{i}@gmail.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role: :member,
    password: "123456",
    password_confirmation: "123456",
    confirmed_at: Time.zone.now
end

training_types = TrainingType.all.includes :categories
puts "Creating training center"
30.times.each do |i|
  training_type = training_types.sample
  training_center = TrainingCenter.create! name: Faker::Educator.university,
    training_type: training_type,
    status: TrainingCenter.statuses.keys.sample,
    description: Faker::Lorem.paragraphs.join("\n")

  training_type.categories.sample(rand(3) + 1).each do |category|
    training_center.training_center_categories.create! category: category
  end
end
