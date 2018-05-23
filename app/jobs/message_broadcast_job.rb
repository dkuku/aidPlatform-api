class MessageBroadcastJob < ApplicationJob
	queue_as  :default

    def perform(message)
		ActionCable.server.broadcast "task_channel", message: message
	end

end
