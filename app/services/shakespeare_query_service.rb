# frozen_string_literal: true

class ShakespeareQueryService
  REQUEST_URL = 'https://api.funtranslations.com/translate/shakespeare.json?'

  def self.call(description)
    request_url = generate_url(description)
    json_response = RestClient.get(request_url)
    JSON.parse(json_response).dig('contents', 'translated')
  end

  def self.generate_url(description)
    formatted_description = description.gsub(/\n/, ' ')
    query_string = { text: formatted_description }.to_query
    REQUEST_URL + query_string
  end
end
