class ApplicationController < ActionController::API
  rescue_from StandardError do |error|
    logger.error("Error: #{error.inspect}")
    render json: { error: 'Something went wrong' }, status: 500
  end

  def route_not_found
    render json: { error: 'Route not found' }, status: 404
  end
end
