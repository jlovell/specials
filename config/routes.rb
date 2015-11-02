Rails.application.routes.draw do
  root 'restaurants#index'

  get ':day', to: 'restaurants#index', constraints: { day: /\w+day/ }

  resources :restaurants do
    member do
      get :show_specials
    end
    collection do
      get :all
    end
  end

  resources :specials
end
