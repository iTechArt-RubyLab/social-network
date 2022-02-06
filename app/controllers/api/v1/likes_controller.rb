# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling like requests.
    class LikesController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit

      before_action :authenticate_user!
      before_action :like, only: %i[destroy]
      before_action :authorize_like!
      after_action :verify_authorized

      def create
        @like = current_user.likes.new(like_params)
        if @like.save
          render json: @like, status: :created
        else
          render json: @like.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @like.destroy
          render json: @like
        else
          render json: { error: 'Error deleting like' }, status: :unprocessable_entity
        end
      end

      private

      def like
        @like = current_user.likes.find(params[:id])
      end

      def like_params
        params.permit(:user, :likeable_id, :likeable_type)
      end

      def authorize_like!
        authorize(@like || Like)
      end
    end
  end
end
