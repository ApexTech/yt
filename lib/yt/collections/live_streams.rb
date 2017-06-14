require 'yt/collections/resources'

module Yt
  module Collections
    class LiveStreams < Resources

    private

      def insert_parts
        keys = [:title, :description]
        snippet = {keys: keys, required: true}
        cdn = {keys: [:format, :ingestion_type]}
        status = {keys: [:privacy_status]}
        {snippet: snippet, status: status, cdn: cdn}
      end

      def attributes_for_new_item(data)
        super(data).tap do |attributes|
          attributes[:statistics] = data['statistics']
          attributes[:cdn] = data['cdn']
        end
      end

      def list_params
        super.tap{|params| params[:params] = channels_params}
      end

      def resources_params
        {max_results: 50, part: 'snippet,cdn,status'}
      end

      def channels_params
        params = resources_params
        params.merge! mine: true if @parent
        apply_where_params! params
      end
    end
  end
end