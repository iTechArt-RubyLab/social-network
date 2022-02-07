# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling profile requests.
    class ProfilesController < ApplicationController
      before_action :set_profile, only: %i[show update]
      before_action :authorize_profile!
      after_action :verify_authorized

      def search
        @profiles = ProfileIndex.search(params[:query].to_s)
        render json: @profiles.records
      end

      # GET /profiles or /profiles.json
      def index
        render json: Profile.all, status: :ok
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

      private

      def set_profile
        @profile = Profile.find_by(user_id: params[:user_id])
      end

      def profile_params
        params.permit(:surname, :name, :patronymic, :birthday, :phone, :about, :user_id)
      end

      def authorize_profile!
        authorize(@profile || Profile)
      end
    end
  end
end
