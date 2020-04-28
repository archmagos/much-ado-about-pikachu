# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pokemon', type: 'request' do
  describe '#show' do
    context 'with a valid Pokémon parameter' do
      let(:pokemon) { 'octillery' }
      let(:pokeapi_description) { 'Pokémon description' }
      let(:description_query) { 'text=Pok%C3%A9mon+description' }
      let(:shakespeare_description) { 'Shakespeare description' }

      context 'with valid external API responses' do
        before do
          expect(RestClient).to receive(:get)
            .with(PokemonController::POKEAPI_URL + pokemon)
            .ordered
            .and_return(pokeapi_response)

          expect(RestClient).to receive(:get)
            .with(PokemonController::SHAKESPEARE_URL + description_query)
            .ordered
            .and_return(shakespeare_api_response)
        end

        let(:pokeapi_response) do
          {
            "flavor_text_entries" => [
              {
                "flavor_text" => pokeapi_description,
                "language"=> {
                  "name" => "en"
                }
              }
            ]
          }.to_json
        end

        let(:shakespeare_api_response) do
          {
            "contents" => {
              "translated" => shakespeare_description
            }
          }.to_json
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
