class StatsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @Task_waiting_count = Task.where(:done => false).count
    @Task_done_count = Task.where(:done => true).count
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
