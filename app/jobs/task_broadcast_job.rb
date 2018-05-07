class TaskBroadcastJob < ApplicationJob
	queue_as  :default

    def perform(task)
		ActionCable.server.broadcast "stats_channel", stats: render_stats()
	end


	def render_stats
	{
	unfulfiled: Task.where(done: false).length,
	fulfiled: Task.where(done: true).length,
	users: User.all.length,
	}
	
	end
end
