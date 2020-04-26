# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application', type: 'request' do
  describe 'error handling' do
    describe '#route_not_found' do
      context 'with an invalid route' do
        it 'returns an error response and 404 status code' do
          get '/incorrect-route'
          expect(response).to have_http_status(404)
          body = JSON.parse(response.body)
          expect(body['error']).to eq('Route not found')
        end
      end
    end
  end
end
