Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  resources :users, except: [:index,:create,:new,] do
    resources :categories, except:[:show] do
      resources :tasks
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
