Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  get "/user", to: 'users#show', as: 'user'
  get "/user/edit", to: 'users#edit', as: 'user_edit'
  resources :users, except: [:index,:create,:new,:show,:edit]
  resources :categories, except:[:edit] do
    resources :tasks, except:[:new,:edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
