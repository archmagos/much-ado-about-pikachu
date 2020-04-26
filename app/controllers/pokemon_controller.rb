# frozen_string_literal: true

class PokemonController < ApplicationController
  def show
    description = 'Pokémon description'
    render json: api_response(description), status: 200
  end

  private

  def api_response(description)
    {
      'name' => params[:pokemon],
      'description' => description
    }
  end
end
