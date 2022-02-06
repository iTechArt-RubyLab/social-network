# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling post requests.
    class PostsController < ApplicationController
      before_action :set_post, except: %i[index create]
      before_action :authorize_post!
      after_action :verify_authorized

      # GET /posts or /posts.json
      def index
        render json: Post.all, status: :ok
      end

      # GET /posts/:id or /posts/:id.json
      def show
        render json: @post, status: :ok
      end

      # POST /posts or /posts.json
      def create
        @post = Post.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PUT or PATCH /posts/:id or /posts/:id.json
      def update
        if @post.update(post_params)
          render json: true, status: :ok
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @post.destroy
          render json: true, status: :no_content
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.permit(:body, :status, :pictures).reverse_merge(user_id: current_user.id)
      end

      def authorize_post!
        authorize(@post || Post)
      end
    end
  end
end
