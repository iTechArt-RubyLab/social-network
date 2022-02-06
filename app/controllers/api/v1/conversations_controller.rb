# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling conversation requests.
    class ConversationsController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit

      before_action :authenticate_user!
      before_action :conversation, only: %i[show destroy update]
      before_action :authorize_conversation!
      after_action :verify_authorized

      def index
        @conversations = Conversation.all
        render json: @conversations, status: :ok
      end

      def show
        if @conversation
          render json: @conversation, status: :ok
        else
          render json: @conversation.errors, status: :not_found
        end
      end

      def create
        @conversation = Conversation.new(conversation_params)
        if @conversation.save
          render json: @conversation, status: :created
        else
          render json: @conversation.errors, status: :unprocessable_entity
        end
      end

      def update
        if @conversation.update(conversation_params)
          render json: @conversation
        else
          render json: @conversation.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @conversation.destroy
          render json: @conversation
        else
          render json: { error: 'Error deleting conversation' }, status: :unprocessable_entity
        end
      end

      private

      def conversation
        @conversation = Conversation.find(params[:id])
      end

      def conversation_params
        params.permit(:name)
      end

      def authorize_conversation!
        authorize(@conversation || Conversation)
      end
    end
  end
end
