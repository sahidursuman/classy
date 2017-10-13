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
districts = District.all.includes :city
puts "Creating training center and its branches"
30.times.each do
  training_type = training_types.sample
  training_center = TrainingCenter.create! name: Faker::Educator.university,
    training_type: training_type,
    status: TrainingCenter.statuses.values.sample,
    description: Faker::Lorem.paragraphs.join("\n")

  category_count = rand(3) + 1
  training_type.categories.sample(category_count).each do |category|
    training_center.training_center_categories.create! category: category
  end

  branches_count = rand(10) + 1
  branches_count.times.each do
    district = districts.sample
    training_center.branches.create! name: training_center.name + " - " + district.name,
      status: Branch.statuses.values.sample,
      description: Faker::Lorem.paragraphs.join("\n"),
      address: Faker::Address.street_address,
      district: district,
      city: district.city
  end
end

puts "Creating reviews"
normal_users = User.all
Branch.find_each do |branch|
  review_count = rand normal_users.size
  normal_users.sample(review_count).each do |user|
    review = branch.reviews.create! user: user,
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraphs.join("\n"),
      rating_criterion_1: Settings.review.rating_values.sample,
      rating_criterion_2: Settings.review.rating_values.sample,
      rating_criterion_3: Settings.review.rating_values.sample,
      rating_criterion_4: Settings.review.rating_values.sample,
      rating_criterion_5: Settings.review.rating_values.sample,
      status: Review.statuses.values.sample
    verification_status = review.verified? ? :verified : [:forwarded, :rejected].sample
    review.review_verifications.create! email: user.email,
      phone_number: Faker::PhoneNumber.cell_phone,
      status: verification_status,
      response_message: Faker::Lorem.sentence
  end
end
