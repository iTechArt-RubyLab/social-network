# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling conversation requests.
    class ConversationsController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit

      before_action :authenticate_user!
      before_action :find_conversation, only: %i[show destroy update]
      before_action :find_conversation_id, only: %i[add_user delete_user]
      before_action :authorize_conversation!
      before_action :verify_authorized

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
        user = User.find_by(id: params[:id])
        if user
          @conversation.users << user
        else
          render json: { error: 'Error adding user' }, status: :unprocessable_entity
        end
      end

      def delete_user
        @conversation.users.delete(User.find_by(id: params[:id]))
        if @conversation.save!
          render json: @conversation
        else
          render json: { error: 'Error deleting user' }, status: :unprocessable_entity
        end
      end

      def create
        @conversation = Conversation.create(conversation_params)
        @conversation.users = User.find_by(id: current_user.id)
        if @conversation.save!
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

      def find_conversation
        @conversation = Conversation.find(params[:id])
      end

      def find_conversation_id
        @conversation = Conversation.find(params[:conversation_id])
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
