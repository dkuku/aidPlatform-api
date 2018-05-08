FactoryBot.define do
  factory :user, class: User do
    id 1
    first_name "John"
    last_name "Smith"
    password "123456"
    password_confirmation "123456"
    email {"#{first_name}@test.com"}
  end
  factory :user1, class: User do
    id 1
    first_name "John"
    last_name "Smith"
    password "123456"
    password_confirmation "123456"
    email {"#{first_name}@test.com"}
  end
  factory :user2, class: User do
    id 2
    first_name "Adam"
    last_name "Ping"
    password "123456"
    password_confirmation "123456"
    email {"#{first_name}@test.com"}
  end
end

FactoryBot.define do
  factory :random_user, class: User do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    password "123456"
    password_confirmation "123456"
    email {Faker::Internet.safe_email}
  end
end

