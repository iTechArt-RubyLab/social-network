# frozen_string_literal: true

module API
  module V1
    # Search
    class SearchController < ActionController::API
      def search_profile
        @profile = ProfileIndex.search(params[:query].to_s)
        render json: @profile.records
      end

      def search_conversation
        @conversations = ConversationIndex.search(params[:query].to_s)
        render json: @conversations.records
      end

      def search_tag
        @tags = TagIndex.search(params[:query].to_s)
        render json: @tags.records
      end
    end
  end
end
