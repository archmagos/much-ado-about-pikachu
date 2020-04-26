# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pokemon', type: 'request' do
  describe '#show' do
    let(:pokemon) { 'octillery' }
    let(:description) { 'Pokémon description' }

    it 'returns a Pokémon name and description' do
      get "/pokemon/#{pokemon}"
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body['name']).to eq(pokemon)
      expect(body['description']).to eq(description)
    end
  end
end
