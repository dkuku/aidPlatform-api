# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create! email: "dan@wp.pl",
    password: "123qwe",
    first_name: "daniel",
    last_name: "kukula"

9.times do |n|
    User.create! email: Faker::Internet.email,
        password: "123qwe",
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
end

20.times do |n|
    Task.create! title: Faker::Book.title,
        description: Faker::Lorem.paragraph(5, true, 5),
        lat: Faker::Address.latitude,
        lng: Faker::Address.longitude,    
        user_id: Faker::Number.between(1,10)
end