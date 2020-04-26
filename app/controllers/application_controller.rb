class ApplicationController < ActionController::API
  rescue_from StandardError do |error|
    basic_error_response(error)
  end

  rescue_from NoMethodError do |error|
    basic_error_response(error)
  end

  def route_not_found
    render json: { error: 'Route not found' }, status: 404
  end

  private

  def basic_error_response(error)
    logger.error("Error: #{error.inspect}")
    render json: { error: 'Something went wrong' }, status: 500
  end
end
