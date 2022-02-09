# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling post requests.
    class PostsController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_post, except: %i[index create]
      before_action :set_tag, only: %i[remove_tag]
      before_action :authorize_post!

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
        if post_params.blank?
          render json: { error: 'There was no post data passed. Post could not be saved.' }, status: :unprocessable_entity
        else
          @post = Post.new(post_params)
          if @post.save
            render json: @post, status: :created
          else
            render json: @post.errors, status: :unprocessable_entity
          end
        end
      end

      # PUT or PATCH /posts/:id or /posts/:id.json
      def update
        if post_params.blank?
          render json: { error: 'There was no post data passed. Post could not be saved.' }, status: :unprocessable_entity
        elsif @post.update(post_params)
          render json: @post, status: :ok
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /posts/:id or /posts/:id.json
      def destroy
        if @post.destroy
          render json: true, status: :no_content
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # POST /posts/:id/add_tag or /posts/:id/add_tag.json
      def add_tag
        tag = Tag.find_or_create_by(tag_params)
        if tag_params.blank?
          render json: { error: 'There was no tag data passed in so your post could not be saved.' },
                 status: :unprocessable_entity
        else
          @post.tags << tag
          if @post.save
            render json: @post, status: :created
          else
            render json: @post.errors, status: :unprocessable_entity
          end
        end
      end

      # DELETE /posts/:post_id/remove_tag/:id or /posts/:post_id/remove_tag/:id.json
      def remove_tag
        @post.tags.destroy(@tag)
        head 204
      end

      private

      def set_post
        @post = Post.find(params[:post_id] || params[:id])
      end

      def set_tag
        @tag = Tag.find(params[:id])
      end

      def post_params
        params.permit(:id, :body, :status, :created_at, :updated_at, :user_id)
      end

      def tag_params
        params.permit(:name)
      end

      def authorize_post!
        authorize(@post || Post)
      end
    end
  end
end
