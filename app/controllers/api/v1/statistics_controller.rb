class Api::V1::StatisticsController < ApplicationController

  def index
      json_response "Current server statistics", true, render_stats, :ok
  end
end

def render_stats
	{
	unfulfiled: Task.where(done: false).count,
	fulfiled: Task.where(done: true).count,
	users: User.all.count
  }
end
