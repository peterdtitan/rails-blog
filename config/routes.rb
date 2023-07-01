Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show create new destroy] do
      resources :comments, only: %i[create new destroy]
      resources :likes, only: %i[create new] do
        collection do
          get :create
        end
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: %i[index show create] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end



end
