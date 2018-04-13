# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User.create! email: "dan@wp.pl",
#    password: "123qwe",
#    first_name: "daniel",
#    last_name: "kukula"
#
#29.times do |n|
#    User.create! email: Faker::Internet.email,
#        password: "123qwe",
#        first_name: Faker::Name.first_name,
#        last_name: Faker::Name.last_name
#end

80.times do |n|
    Task.create! title: Faker::Book.title,
        description: Faker::Lorem.paragraph(1, true, 4),
        lat: Faker::Number.normal(51.5, 0.1),
        lng: Faker::Number.normal(-0.2, 0.2),
        user_id: Faker::Number.between(1,10),
        task_type: ["material", "help"].sample,
        done: Faker::Boolean.boolean,
        fulfilment_counter: Faker::Number.between(0,5)
end
