require 'yt/models/resource'

module Yt
  module Models
    # Provides methods to interact with YouTube channels.
    # @see https://developers.google.com/youtube/v3/docs/liveStream
    class LiveStream < Resource
      delegate :title, to: :snippet

      delegate :channel_id, to: :snippet

      delegate :description, to: :snippet

      delegate :published_at, to: :snippet

      delegate :format, to: :cdn

      delegate :ingestion_type, to: :cdn

      has_one :cdn

      def initialize(options = {})
        super
      end

      def update_parts
        keys = [:title, :description]
        snippet = {keys: keys, required: true}
        cdn = {keys: [:format, :ingestion_type]}
        status = {keys: [:privacy_status]}
        {snippet: snippet, status: status, cdn: cdn}
      end
    end
  end
end