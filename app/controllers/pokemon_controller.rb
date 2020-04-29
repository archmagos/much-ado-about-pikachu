# frozen_string_literal: true

class PokemonController < ApplicationController
  include PokemonSpecies

  before_action :validate_params

  POKEAPI_URL = 'https://pokeapi.co/api/v2/pokemon-species/'
  SHAKESPEARE_URL = 'https://api.funtranslations.com/translate/shakespeare.json?'

  def show
    pokemon_description = get_pokemon_description
    converted_description = get_converted_description(pokemon_description)
    render json: api_response(converted_description), status: 200
  end

  private

  def validate_params
    unless POKEMON_SPECIES.include?(params[:pokemon])
      raise InvalidParameterError
    end
  end

  def get_pokemon_description
    pokeapi_response = RestClient.get(POKEAPI_URL + params[:pokemon])
    flavour_text_entries = JSON.parse(pokeapi_response).dig('flavor_text_entries')
    flavour_text = flavour_text_entries.select { |ft| ft.dig('language', 'name') == 'en' }
    flavour_text.first.dig('flavor_text')
  end

  def get_converted_description(description)
    description_query = { text: description.gsub(/\n/, ' ') }.to_query
    shakespeare_response = RestClient.get(SHAKESPEARE_URL + description_query)
    JSON.parse(shakespeare_response).dig('contents', 'translated')
  end

  def api_response(description)
    {
      'name' => params[:pokemon],
      'description' => description
    }
  end
end
