Rails.application.routes.draw do

  scope :api do
    resources :restaurants, only: [] do
      resources :reservations, only: [:index, :create, :update]
    end
  end


end
