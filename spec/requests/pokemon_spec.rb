# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pokemon', type: 'request' do
  describe '#show' do
    context 'with a valid Pokémon parameter' do
      let(:pokemon) { 'octillery' }

      context 'with valid API responses' do
        let(:pokemon_description) { 'Pokémon description' }
        let(:shakespeare_description) { 'Shakespeare description' }

        before do
          expect(PokeapiQueryService)
            .to receive(:call)
            .with(pokemon)
            .and_return(pokemon_description)

          expect(ShakespeareQueryService)
            .to receive(:call)
            .with(pokemon_description)
            .and_return(shakespeare_description)
        end

        it 'returns a Pokémon name and description' do
          get "/pokemon/#{pokemon}"
          expect(response).to have_http_status(200)
          body = JSON.parse(response.body)
          expect(body['name']).to eq(pokemon)
          expect(body['description']).to eq(shakespeare_description)
        end
      end
    end

    context 'with an invalid Pokémon parameter' do
      let(:invalid_param) { 'InVaLiDpOkEmOn123' }
      it 'returns an error response and 422 status code' do
        get "/pokemon/#{invalid_param}"
        expect(response).to have_http_status(422)
        body = JSON.parse(response.body)
        expect(body['error']).to eq("Parameter '#{invalid_param}' is not a valid Pokémon")
      end
    end
  end
end
