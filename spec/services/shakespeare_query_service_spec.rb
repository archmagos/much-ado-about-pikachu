# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShakespeareQueryService do
  let(:subject) { described_class }
  let(:description) { 'Pokémon description' }
  let(:description_query) { 'text=Pok%C3%A9mon+description' }
  let(:shakespeare_description) { 'Shakespeare description' }
  let(:api_response) do
    {
      'contents' => {
        'translated' => shakespeare_description
      }
    }.to_json
  end

  describe '#self.call' do
    before do
      expect(RestClient)
        .to receive(:get)
        .with(ShakespeareQueryService::REQUEST_URL + description_query)
        .and_return(api_response)
    end

    it 'returns the converted Shakespeare description' do
      expect(subject.call(description)).to eq(shakespeare_description)
    end
  end
end
