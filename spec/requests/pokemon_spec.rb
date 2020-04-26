# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pokemon', type: 'request' do
  describe '#show' do
    let(:pokemon) { 'octillery' }

    it 'functions as a route, with expected param' do
      get "/pokemon/#{pokemon}"
      expect(response.code).to eq('200')
      expect(response.body).to eq(pokemon)
    end
  end
end
