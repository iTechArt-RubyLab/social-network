# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling tag requests.
    class TagsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_tag, only: %i[show posts]
      before_action :authorize_tag!

      # GET /tags or /tags.json
      def index
        @tag = Tag.all
        render json: @tag, status: :ok
      end

      # GET /tags/:id or /tags/:id.json
      def show
        render json: @tag, status: :ok
      end

      # POST /tags or /tags.json
      def create
        if tag_params.blank?
          render json: { error: 'There was no tag data passed in so your tag could not be saved.' }, status: :unprocessable_entity
        else
          @tag = Tag.new(tag_params)
          if @tag.save
            render json: @tag, status: :created
          else
            render json: @tag.errors, status: :unprocessable_entity
          end
        end
      end

      # GET /tags/:tag_id/posts or /tags/:tag_id/posts.json
      def posts
        posts = @tag.posts
        render json: posts, status: :ok
      end

      private

      def set_tag
        @tag = Tag.find(params[:tag_id] || params[:id])
      end

      def tag_params
        params.permit(:name)
      end

      def authorize_tag!
        authorize(@tag || Tag)
      end
    end
  end
end
