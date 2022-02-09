# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling message requests.
    class MessagesController < ApplicationController
      before_action :set_message, except: :create
      before_action :new, only: :create
      before_action :authorize_message!
      after_action :verify_authorized

      def new
        @message = Message.new(message_params)
      end

      # POST /messages or /messages.json
      def create
        if @message.save
          render json: @message, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # PUT /messages/:id or /messages/:id.json
      def update
        if @message.update(text: params[:text])
          render json: @message, status: :ok
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # DELETE /messages/:id or /messages/:id.json
      def destroy
        if @message.destroy
          render json: true, status: :no_content
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      private

      def set_message
        @message = Message.find(params[:id])
      end

      def message_params
        params.permit(:text, :conversation_id).reverse_merge(user_id: current_user.id)
      end

      def authorize_message!
        authorize(@message || Message)
      end
    end
  end
end
