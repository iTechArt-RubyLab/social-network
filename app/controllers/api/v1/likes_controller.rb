# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling like requests.
    class LikesController < ApplicationController
      before_action :find_like, only: %i[destroy]
      before_action :authorize_like!

      def index
        post = Post.find_by(id: params[:post_id])
        if post
          likes = Like.find_by(likeable_id: params[:post_id])
          render json: likes
        else
          render json: { error: 'Post does not exist.' }, status: :not_found
        end
      end

      def create
        like = current_user.likes.new(like_params)
        if like.save
          render json: like, status: :created
        else
          render json: like.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @like.destroy
          render json: @like
        else
          render json: { error: 'Error deleting like' }, status: :not_found
        end
      end

      private

      def find_like
        @like = current_user.likes.find(params[:id])
      end

      def like_params
        params.permit(:user, :likeable_id, :likeable_type)
      end
      end
    end
  end
end
