FactoryBot.define do
    factory :conversation, class: Conversation do
        volunteer_id 2
        task_id 1
		task_owner_id 1
    end
    factory :conversation1, class: Conversation do
        volunteer_id 1
        task_id 1
		task_owner_id 1
    end
    factory :conversation2, class: Conversation do
        volunteer_id 2
        task_id 1
		task_owner_id 1
	end
    factory :conversation3, class: Conversation do
        volunteer_id 3
        task_id 1
		task_owner_id 1
	end
end
