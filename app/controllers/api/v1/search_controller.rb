# frozen_string_literal: true

module API
  module V1
    # Search
    class SearchController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit

      before_action :authenticate_user!

      def search_profile
        @profiles = ProfileIndex.search(params[:query].to_s)
        render json: @profiles.records
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
