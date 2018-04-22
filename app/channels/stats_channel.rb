class StatsChannel < ApplicationCable::Channel
  def subscribed
	stream_from 'stats_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
