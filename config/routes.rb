Rails.application.routes.draw do
  resources :pokemon, param: :pokemon, only: [:show]

  match '*undefined', to: 'application#route_not_found', via: :all
end
