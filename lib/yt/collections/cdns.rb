require 'yt/collections/base'
require 'yt/models/cdn'

module Yt
  module Collections
    # @private
    class Cdns < Base

    private

      def attributes_for_new_item(data)
        {data: data['cdn'], auth: @auth}
      end

      def list_params
        endpoint = @parent.kind.pluralize.camelize :lower
        super.tap do |params|
          params[:path] = "/youtube/v3/#{endpoint}"
          params[:params] = {id: @parent.id, part: 'cdn'}
        end
      end
    end
  end
end