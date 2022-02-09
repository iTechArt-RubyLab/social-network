class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  before_action :authenticate_user!, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    if user_signed_in?
      render json: '403 Forbidden', status: :forbidden
    else
      render json: '401 Unauthorized', status: :unauthorized
    end
  end
end
