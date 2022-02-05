# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling user subscriptions requests.
    class LikesController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit

      before_action :authenticate_user!
      before_action :set_like, only: %i[destroy]
      before_action :authorize_like!
      after_action :verify_authorized

      # POST /user_subscriptions or /user_subscriptions.json
      def create
        if like_params.blank?
          render json: { error: 'error' },
                 status: :unprocessable_entity
        else
          @like = current_user.likes.new(like_params)
          if @like.save
            render json: @like, status: :created
          else
            render json: @like.errors, status: :unprocessable_entity
          end
        end
      end

      # DELETE /user_subscriptions/:id or /user_subscriptions:id.json
      def destroy
        @like.destroy
        head 204
      end

      private

      def set_like
        @like = current_user.likes.find(params[:id])
      end

      def like_params
        params.permit(:likeable,:user)
      end

      def authorize_like!
        authorize(@like || Like)
      end
    end
  end
end