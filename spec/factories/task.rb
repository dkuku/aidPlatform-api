FactoryBot.define do
  factory :task, class: Task do
    title "title"
    description "body"
    lat 51.52
    lng 0.1
    user_id 1
    task_type "material"
    done false
    fulfilment_counter 0
  end
  factory :task1, class: Task do
    title "title"
    description "body"
    lat 51.52
    lng 0.1
    user_id 1
    task_type "material"
    done false
    fulfilment_counter 0
  end

  factory :task_done, class: Task do
    title "first test task"
    description "first test task body"
    lat 51.52
    lng 0.1
    user_id 1 
    task_type "material"
    done false
    fulfilment_counter 0
  end
  factory :random_task, class: Task do
    title {Faker::Book.title}
    description {Faker::Lorem.paragraph(1, true, 4)}
    lat {Faker::Number.normal(51.5, 0.1)}
    lng {Faker::Number.normal(-0.2, 0.2)}
    user_id 1 
    task_type {["material", "help"].sample}
    done {Faker::Boolean.boolean}
    fulfilment_counter {Faker::Number.between(0,5)}
  end
end

