# frozen_string_literal: true

class PokemonController < ApplicationController
  def show
    render json: params[:pokemon], status: 200
  end
end
