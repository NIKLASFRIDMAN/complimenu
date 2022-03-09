class TableroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    tableroom = Table.find(params[:table_id])
    stream_for tableroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
