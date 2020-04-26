# frozen_string_literal: true

class PokemonController < ApplicationController
  POKEAPI_URL = 'https://pokeapi.co/api/v2/pokemon-species/'
  SHAKESPEARE_URL = 'https://api.funtranslations.com/translate/shakespeare.json'

  def show
    description = pokeapi_request
    description = shakespeare_request(description)
    render json: api_response(description), status: 200
  end

  private

  def pokeapi_request
    result = RestClient.get(POKEAPI_URL + params[:pokemon])
    result = JSON.parse(result).dig('flavor_text_entries')
    result = result.select { |ft| ft.dig('language', 'name') == 'en' }
    result.first.dig('flavor_text')
  end

  def shakespeare_request(description)
    result = RestClient.get(SHAKESPEARE_URL, text: description)
    JSON.parse(result).dig('contents', 'translated')
  end

  def api_response(description)
    {
      'name' => params[:pokemon],
      'description' => description
    }
  end
end
