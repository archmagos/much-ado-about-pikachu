# frozen_string_literal: true

class PokemonController < ApplicationController
  POKEAPI_URL = 'https://pokeapi.co/api/v2/pokemon-species/'
  SHAKESPEARE_URL = 'https://api.funtranslations.com/translate/shakespeare.json?'

  def show
    validate_params
    pokeapi_description = pokeapi_request
    shakespeare_description = shakespeare_request(pokeapi_description)
    render json: api_response(shakespeare_description), status: 200
  end

  private

  def validate_params
    unless POKEMON_SPECIES.include?(params[:pokemon])
      raise InvalidParameterError
    end
  end

  def pokeapi_request
    pokeapi_response = RestClient.get(POKEAPI_URL + params[:pokemon])
    flavour_text_entries = JSON.parse(pokeapi_response).dig('flavor_text_entries')
    flavour_text = flavour_text_entries.select { |ft| ft.dig('language', 'name') == 'en' }
    flavour_text.first.dig('flavor_text')
  end

  def shakespeare_request(description)
    formatted_description = description.gsub(/\n/, ' ')
    description_query = { text: formatted_description }.to_query
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
