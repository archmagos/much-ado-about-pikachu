# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pokemon', type: 'request' do
  describe '#show' do
    let(:pokemon) { 'octillery' }
    let(:description) { 'Pokémon description' }

    before do
      expect(RestClient).to receive(:get)
        .with(PokemonController::POKEAPI_URL + pokemon)
        .and_return(pokeapi_response)
    end

    context 'with a valid PokéAPI response' do
      let(:pokeapi_response) do
        {
          "flavor_text_entries" => [
            {
              "flavor_text" => description,
              "language"=> {
                "name" => "en"
              }
            }
          ]
        }.to_json
      end

      it 'returns a Pokémon name and description' do
        get "/pokemon/#{pokemon}"
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['name']).to eq(pokemon)
        expect(body['description']).to eq(description)
      end
    end

    context 'with an invalid PokéAPI response' do
      context 'with a null response' do

      end

      context 'with an error response' do

      end
    end
  end
end
