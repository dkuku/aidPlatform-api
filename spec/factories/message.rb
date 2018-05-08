FactoryBot.define do
    factory :message, class: Message do
        volunteer_id 2
		task_owner_id 1
       conversation_id 1
		task_id 1
       body "lorem ipsum"
    end
    factory :message1, class: Message do
   	   volunteer_id 1
		task_owner_id 1
       conversation_id 1
		task_id 1
       body "lorem ipsum"
    end
    factory :message2, class: Message do
   	   volunteer_id 2
		task_owner_id 1
       conversation_id 1
		task_id 1
       body "lorem ipsum"
    end
    factory :message3, class: Message do
   	   volunteer_id 3
		task_owner_id 1
       conversation_id 1
		task_id 1
       body "lorem ipsum"
    end
end
