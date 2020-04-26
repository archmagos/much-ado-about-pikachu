class ApplicationController < ActionController::API
  rescue_from StandardError do |error|
    basic_error_response(error)
  end

  rescue_from NoMethodError do |error|
    basic_error_response(error)
  end

  rescue_from RestClient::TooManyRequests do |error|
    log_error(error)
    render json: { error: 'Too many free requests to an external API' }, status: 502
  end

  def route_not_found
    render json: { error: 'Route not found' }, status: 404
  end

  private

  def basic_error_response(error)
    log_error(error)
    render json: { error: 'Something went wrong' }, status: 500
  end

  def log_error(error)
    logger.error("Error: #{error.inspect}")
  end
end
