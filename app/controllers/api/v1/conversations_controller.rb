# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling conversation requests.
    class ConversationsController < ApplicationController
      before_action :find_conversation, only: %i[show destroy update add_user delete_user]
      before_action :authorize_conversation!

      def index
        @conversations = current_user.conversations
        render json: @conversations, status: :ok
      end

      def show
        if @conversation
          render json: @conversation, status: :ok
        else
          render json: @conversation.errors, status: :not_found
        end
      end

      def add_user
        user = User.find_by(id: params[:user_id])
        if user && @conversation
          @conversation.users << user
          render json: @conversation, status: :ok
        else
          render json: { error: 'Error adding user' }, status: :unprocessable_entity
        end
      end

      def delete_user
        @conversation.users.delete(User.find_by(id: params[:user_id]))
        if @conversation.save!
          render json: @conversation
        else
          render json: { error: 'Error deleting user' }, status: :unprocessable_entity
        end
      end

      def create
        conversation = Conversation.create(conversation_params)
        conversation.users << current_user
        if conversation.save!
          render json: conversation, status: :created
        else
          render json: conversation.errors, status: :unprocessable_entity
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

      def find_conversation
        @conversation = Conversation.find_by(id: params[:id] || params[:conversation_id])
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
