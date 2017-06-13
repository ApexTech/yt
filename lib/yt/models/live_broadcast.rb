require 'yt/models/resource'

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

      def update_parts
        keys = [:title, :description, :scheduled_start_time, :scheduled_end_time]
        snippet = {keys: keys, required: true}
        status = {keys: [:privacy_status]}
        {snippet: snippet, status: status}
      end
    end
  end
end
