# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokeapiQueryService do
  let(:subject) { described_class }
  let(:pokemon) { 'octillery' }
  let(:pokeapi_description) { 'Pokémon description' }
  let(:api_response) do
    {
      'flavor_text_entries' => [
        {
          'flavor_text' => pokeapi_description,
          'language' => {
            'name' => 'en'
          }
        }
      ]
    }.to_json
  end

  describe '#self.call' do
    before do
      expect(RestClient)
        .to receive(:get)
        .with(PokeapiQueryService::REQUEST_URL + pokemon)
        .and_return(api_response)
    end

    it 'returns the Pokémon flavor text' do
      expect(subject.call(pokemon)).to eq(pokeapi_description)
    end
  end
end
