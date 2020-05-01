# frozen_string_literal: true

class PokemonController < ApplicationController
  include PokemonSpecies
  before_action :validate_params, only: :show

  def show
    pokemon_description = PokeapiQueryService.call(params[:pokemon])
    converted_description = ShakespeareQueryService.call(pokemon_description)
    render json: show_response(converted_description), status: :ok
  end

  private

  def validate_params
    return if POKEMON_SPECIES.include?(params[:pokemon])

    raise InvalidParameterError
  end

  def show_response(converted_description)
    {
      'name' => params[:pokemon],
      'description' => converted_description
    }
  end
end
