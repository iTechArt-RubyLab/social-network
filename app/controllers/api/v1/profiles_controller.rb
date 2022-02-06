# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling profile requests.
    class ProfilesController < ApplicationController
      before_action :authorize_profile!
      before_action :set_profile, except: %i[index create]
      before_action :set_tag, only: %i[remove_tag]
      after_action :verify_authorized

      # GET /profiles or /profiles.json
      def index
        profiles = Profile.all
        render json: profiles, status: :ok
      end

      # GET /profiles/:id or /profiles/:id.json
      def show
        render json: @profile, status: :ok
      end

      # POST /profiles or /profiles.json
      def create
        @profile = Profile.new(profile_params)
        if @profile.save
          render json: @profile, status: :created
        else
          render json: @profile.errors, status: :unprocessable_entity
        end
      end

      # PUT /profiles/:id or /profiles/:id.json
      def update
        if @profile.update(profile_params)
          render json: true, status: :ok
        else
          render json: @profile.errors, status: :unprocessable_entity
        end
      end

      # POST /profiles/:id/add_tag or /profiles/:id/add_tag.json
      def add_tag
        tag = Tag.find_or_create_by(params[:tag])
        if tag_params.blank?
          render json: { error: 'There was no tag data passed in so your profile could not be saved.' },
                 status: :unprocessable_entity
        else    
          if @profile.tags << tag
            render json: @profile, status: :created
          else
            render json: @profile.errors, status: :unprocessable_entity
          end
        end
      end

      def set_profile
        @profile = Profile.find_by(user_id: params[:user_id])
      end

      # DELETE /profiles/:profile_id/remove_tag/:id or /profiles/:profile_id/remove_tag/:id.json
      def remove_tag
        @profile.tags.destroy(@tag)
        head 204
      end

      private

      def set_tag
        @tag = Tag.find_by(name: params[:name])
      end

      def profile_params
        params.permit(:surname, :name, :patronymic, :birthday, :phone, :about, :user_id)
      end

      def tag_params
        params.permit(:name)
      end

      def authorize_profile!
        authorize(@profile || Profile)
      end
    end
  end
end
