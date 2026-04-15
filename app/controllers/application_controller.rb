class ApplicationController < ActionController::API
  before_action :authenticate_request!

  private

  def authenticate_request!
    # API key passed in the X-Api-Key header by MSM
    # We compare against an env variable — never hardcode secrets
    api_key = request.headers["X-Api-Key"]
    unless api_key.present? && ActiveSupport::SecurityUtils.secure_compare(
      api_key, ENV.fetch("MSM_API_KEY", "")
    )
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end