# frozen_string_literal: true

module API
  module V1
    # User Endpoints Controller
    class UsersController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit

      before_action :authenticate_user!
      before_action :set_user, only: :show
      before_action :authorize_user!, only: :show
      after_action :verify_authorized, only: :show

      def index
        @users = User.all
        render json: @users, status: :ok
      end

      def show
        render json: @user, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def authorize_user!
        authorize(@user)
      end
    end
  end
end
