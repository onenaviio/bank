Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: %i[index show create]
      resources :cards, only: %i[index show create update]
      resources :users, only: %i[create]
    end
  end
end
