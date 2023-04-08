Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :operations do
        resources :cards do
          member do
            post :replenishment
            post :send_money
            post :withdrawals
          end
        end

        resource :commissions, only: %i[show]
      end

      resources :accounts, only: %i[index show create]
      resources :cards, only: %i[index show create update]
      resources :users, only: %i[create]
    end
  end
end
