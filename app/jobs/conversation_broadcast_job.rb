class ConversationBroadcastJob < ApplicationJob
	queue_as  :default

    def perform(conversation)
		ActionCable.server.broadcast "task_channel#{conversation.task_id}", conversation: conversation
	end

end
