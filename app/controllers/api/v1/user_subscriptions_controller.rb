# frozen_string_literal: true

module API
  module V1
    # Controller class that is responsible for handling user subscriptions requests.
    class UserSubscriptionsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_subscription
      before_action :authorize_user!

      # POST /users/:user_id/subscribe or /users/:user_id/subscribe.json
      def subscribe
        if current_user.subscriptions << @subscription
          render json: @subscription, status: :created
        else
          render json: @subscription.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/:user_id/unsubscribe or /users/:user_id/unsubscribe.json
      def unsubscribe
        current_user.subscriptions.destroy(@subscription)
        head 204
      end

      # GET /users/:user_id/subscribers or /users/:user_id/subscribers.json
      def subscribers
        subscribers = @subscription.subscribers
        render json: subscribers, status: :ok
      end

      # GET /users/:user_id/subscriptions or /users/:user_id/subscriptions.json
      def subscriptions
        subscriptions = @subscription.subscriptions
        render json: subscriptions, status: :ok
      end

      private

      def set_subscription
        @subscription = User.find(params[:user_id])
      end

      def authorize_user!
        authorize(@user || User)
      end
    end
  end
end
