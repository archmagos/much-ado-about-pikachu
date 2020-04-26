# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application', type: 'request' do
  describe 'error handling' do
    describe '#route_not_found' do
      context 'with an invalid route' do
        it 'returns an error response and 404 status code' do
          get '/incorrect-route'
          expect(response.code).to eq('404')
          expect(response.body).to eq('Route not found')
        end
      end
    end
  end
end
