# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from NoMethodError, with: :basic_error_response
  rescue_from StandardError, with: :basic_error_response

  rescue_from InvalidParameterError, with: :invalid_parameter_response
  rescue_from RestClient::TooManyRequests, with: :too_many_requests_response

  def route_not_found
    render json: { error: 'Route not found' }, status: :not_found
  end

  private

  def log_error(error)
    logger.error("Error: #{error.inspect}")
  end

  def basic_error_response(error)
    log_error(error)
    error_message = 'Something went wrong'
    render json: { error: error_message }, status: :internal_server_error
  end

  def invalid_parameter_response(error)
    log_error(error)
    error_message = "Parameter '#{params[:pokemon]}' is not a valid Pokémon"
    render json: { error: error_message }, status: :unprocessable_entity
  end

  def too_many_requests_response(error)
    log_error(error)
    error_message = 'Too many requests to an external API'
    render json: { error: error_message }, status: :too_many_requests
  end
end
