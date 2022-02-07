class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    render json: '403 Forbidden', status: :forbidden
  end
end
