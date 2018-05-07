class Api::V1::StatisticsController < ApplicationController

  def index
      json_response "Current server statistics", true, render_stats, :ok
  end
end

def render_stats
	{
	unfulfiled: Task.where(done: false).length,
	fulfiled: Task.where(done: true).length,
	users: User.all.length
  }
end