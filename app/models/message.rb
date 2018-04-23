class Message < ApplicationRecord
   belongs_to :conversation
   validates_presence_of :body, :volunteer_id, :task_owner_id, :task_id, :conversation_id
   def message_time
     created_at.strftime("%m/%d/%y at %l:%M %p")
   end
end
