class TaskBroadcastJob < ApplicationJob
	queue_as  :default

    def perform(task)
		ActionCable.server.broadcast "stats_channel", stats: render_stats()
	end


	def render_stats
	{
	unfulfiled: Task.where(done: false).count,
	fulfiled: Task.where(done: true).count,
	users: User.all.count,
	}
	
	end
end
