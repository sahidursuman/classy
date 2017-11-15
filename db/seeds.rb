Rake::Task["master_data:import"].invoke

puts "Create temporary 'course_sub_categories'"
CourseCategory.all.each do |category| 
  count = Faker::Number.between 3, 5
  count.times do |i|
    category.course_sub_categories.create! name: category.name + " - level #{i + 1}"
  end
end


puts "Creating admin account"
User.create! email: "admin@gmail.com",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  role: :admin,
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.zone.now,
  avatar: open("app/assets/images/default-avatar.png")

puts "Creating moderator account"
User.create! email: "moderator@gmail.com",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  role: :moderator,
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.zone.now,
  avatar: open("app/assets/images/default-avatar.png")

puts "Creating normal users"
10.times.each do |i|
  User.create! email: "member#{i}@gmail.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role: :normal_user,
    password: "123456",
    password_confirmation: "123456",
    confirmed_at: Time.zone.now,
    avatar: open("app/assets/images/default-avatar.png")
end

center_categories = CenterCategory.all
districts = District.all.includes :city
puts "Creating center"
20.times.each do
  center_category = center_categories.sample
  center = Center.create! name: Faker::Educator.university,
    center_category: center_category,
    status: :active,
    description: Faker::Lorem.paragraphs.join("\n")
end


sample_locations = [
  {latitude: 21.063590, longitude: 105.842285},
  {latitude: 21.080895, longitude: 105.749686},
  {latitude: 21.026275, longitude: 105.812005},
  {latitude: 20.986202, longitude: 105.839836},
  {latitude: 21.108168, longitude: 105.814410},
  {latitude: 20.969633, longitude: 105.863441},
  {latitude: 20.993302, longitude: 105.880452},
  {latitude: 20.962160, longitude: 105.798326},
  {latitude: 20.949449, longitude: 105.776151},
  {latitude: 20.998405, longitude: 105.958812},
  {latitude: 21.081203, longitude: 105.920982}
]
puts "Create branches"
Branch.skip_callback :validation, :after, :geocode
Center.find_each do |center|
  branches_count = rand(10) + 1
  branches_count.times.each do |i|
    district = districts.sample
    center.branches.create! name: district.name,
      status: :active,
      description: Faker::Lorem.paragraphs.join("\n"),
      address: Faker::Address.street_address,
      avatar: Faker::Avatar.image,
      district: district,
      city: district.city,
      latitude: sample_locations[i][:latitude],
      longitude: sample_locations[i][:longitude],
      phone_number: Faker::Number.number(10),
      cached_avarage_rating: rand(4) + 1
  end
end
Branch.set_callback :validation, :after, :geocode

puts "Create center managers"
total_center_manager = 0
Center.find_each do |center|
  manager_count = rand(3) + 1
  manager_count.times.each do
    total_center_manager += 1
    user = User.create! email: "centermanager#{total_center_manager}@gmail.com",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      role: :center_manager,
      password: "123456",
      password_confirmation: "123456",
      confirmed_at: Time.zone.now,
      avatar: open("app/assets/images/default-avatar.png")
    center.center_managements.create! user: user
  end
end

centers = Center.all.includes :branches, :center_category
puts "Create branch managers"
total_branch_manager = 0
centers.each do |center|
  manger_count = rand 3
  branch_count = center.branches.size
  manger_count.times.each do
    total_branch_manager += 1
    user = User.create! email: "branchmanager#{total_branch_manager}@gmail.com",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      role: :branch_manager,
      password: "123456",
      password_confirmation: "123456",
      confirmed_at: Time.zone.now,
      avatar: open("app/assets/images/default-avatar.png")
    center.branches.sample(rand(branch_count) + 1).each do |branch|
      user.branch_managements.create! branch: branch
    end
  end
end

puts "Creating reviews"
normal_users = User.normal_user
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

puts "Creating comments"
reviews = Review.verified.limit(50).includes :user, branch: :branch_managers
reviews.each do |review|
  review_count = rand 10
  review_count.times do
    if rand(2) == 0
      UserComment.create! user: normal_users.sample,
        content: Faker::Lorem.paragraph,
        review: review
    elsif branch_manager = review.branch.branch_managers.sample
      CenterComment.create! user: branch_manager,
        content: Faker::Lorem.paragraph,
        review: review,
        branch: review.branch
    end
  end
end

puts "Creating votes"
reviews.each do |review|
  vote_count = rand 10
  normal_users.sample(vote_count).each do |user|
    next if user == review.user
    Vote.create user: user,
      review: review,
      vote_type: Vote::vote_types.values.sample
  end
end

puts "Creating courses"
centers.each do |center|
  course_count = Faker::Number.between 5, 10
  course_categories = center.center_category.course_categories 
  course_count.times do |i|
    course_category = course_categories.sample
    course_sub_category_ids = course_category.course_sub_categories
      .ids.sample(Faker::Number.between 1, 3)
    course = center.courses.create! name: "Course #{course_category.name} k#{i+1}",
      category_id: course_category.id,
      input: Faker::Lorem.sentence,
      output: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraphs.join("\n"),
      price: Faker::Number.between(20, 500) * 10_000,
      course_sub_category_ids: course_sub_category_ids
  end
end

