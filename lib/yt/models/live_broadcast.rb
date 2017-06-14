require 'yt/models/resource'

"LiveBroadcast".pluralize.camelize :lower
module Yt
  module Models
    # Provides methods to interact with YouTube channels.
    # @see https://developers.google.com/youtube/v3/docs/liveBroadcasts
    class LiveBroadcast < Resource
      delegate :title, to: :snippet

      delegate :channel_id, to: :snippet

      delegate :description, to: :snippet

      delegate :thumbnails, to: :snippet

      delegate :published_at, to: :snippet

      has_one :content_detail

      has_one :live_stream

      delegate :bound_stream_id, to: :content_detail

      def update_parts
        keys = [:title, :description, :scheduled_start_time, :scheduled_end_time]
        snippet = {keys: keys, required: true}
        status = {keys: [:privacy_status]}
        content_details = {keys: [:bound_stream_id]}
        {snippet: snippet, status: status, content_details: content_details}
      end

      def bind_to_stream(stream_id)
        HTTParty.post(
          "https://content.googleapis.com/youtube/v3/liveBroadcasts/bind",
          query: { id: id, part: :id, streamId: stream_id },
          headers: { Authorization: "Bearer #{@auth.access_token}" }
        ).ok?
      end
    end
  end
end
