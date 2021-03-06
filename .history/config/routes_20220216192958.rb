Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  resources :users, except: [:index,:create,:new]
  resources :categories, except:[:edit] do
    resources :tasks, except:[:new,:edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
