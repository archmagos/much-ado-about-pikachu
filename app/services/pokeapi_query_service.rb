# frozen_string_literal: true

class PokeapiQueryService
  REQUEST_URL = 'https://pokeapi.co/api/v2/pokemon-species/'

  def self.call(pokemon)
    request_url = REQUEST_URL + pokemon
    json_response = RestClient.get(request_url)
    parsed_response = JSON.parse(json_response)
    get_flavor_text(parsed_response)
  end

  def self.get_flavor_text(parsed_response)
    flavor_text_entries = parsed_response.dig('flavor_text_entries')
    flavor_text = flavor_text_entries.select do |ft|
      ft.dig('language', 'name') == 'en'
    end
    flavor_text.first.dig('flavor_text')
  end
end
