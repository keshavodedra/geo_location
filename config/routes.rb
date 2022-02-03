Rails.application.routes.draw do
  namespace :api do
    resources :geo_locations, only: [:index, :create, :destroy] do
      collection do
        delete 'delete_my_locations'
      end
    end
  end
  match '*unmatched', to: 'application#route_not_found', via: :all

end
