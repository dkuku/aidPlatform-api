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

User.create! email: "mark@wp.pl",
    password: "123qwe",
    first_name: "Mark",
    last_name: "Tester"


8.times do |n|
    User.create! email: Faker::Internet.email,
        password: "123qwe",
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
end

(1..5).each do |counter|
    Task.create! title: Faker::Book.title,
    description: Faker::Lorem.paragraph(1, true, 4),
    lat: Faker::Number.normal(51.5, 0.1),
    lng: Faker::Number.normal(-0.2, 0.2),
    user_id: counter,
    task_type: "material",
    done: false
    (0..3).each do |conver|
        Conversation.create(volunteer_id: conver+ counter+1 , task_owner_id:conver + counter, task_id: counter)
        8.times do |message|
            Message.create!(conversation_id: counter + conver ,
            body:Faker::Lorem.word, 
            volunteer_id: counter+1, 
            task_owner_id:counter, 
            task_id: counter,
            owner: [true, false].sample )
       end
    end
end

10.times do |n|
    Task.create! title: Faker::Book.title,
        description: Faker::Lorem.paragraph(1, true, 4),
        lat: Faker::Number.normal(51.5, 0.1),
        lng: Faker::Number.normal(-0.2, 0.2),
        user_id: [1,2].sample,
        task_type: ["material", "help"].sample,
        done: Faker::Boolean.boolean,
        fulfilment_counter: Faker::Number.between(0,5)
end
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
