FactoryBot.define do
    factory :message, class: Message do
        user_id 2
       conversation_id 1
       body "lorem ipsum"
    end
end
