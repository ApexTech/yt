module Yt
  module Models
    class Cdn < Base
      attr_reader :data, :ingestion_info

      has_attribute :format, default: '1080p'
      has_attribute :ingestion_type, default: 'rtmp'

      def initialize(options = {})
        @data = options.fetch(:data, {}) || {}
        @ingestion_info = data.fetch("ingestionInfo", {})
        super()
      end

      def stream_name
        @ingestion_info["streamName"]
      end

      def ingestion_address
        @ingestion_info["ingestionAddress"]
      end

      def backup_ingestion_address
        @ingestion_info["backupIngestionAddress"]
      end
    end
  end
end
