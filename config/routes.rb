Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get 'api_action_descriptions/create'
  get 'pages/how_it_works', as: :how_it_works
  get 'pages/about', as: :about

  resources :users, only: [:show]
  resources :api_hosts, only: [:index] do
    collection do
      post :echo
    end
  end
  resources :api_versions, only: [:index, :show]
  resources :api_resources, only: [:index, :show]

  get 'api_examples/curl/:id' => 'api_examples#curl', as: :curl_api_example
  get 'api_actions/details', as: :details_api_action

  resources :api_action_descriptions, only: [:create, :update, :destroy] do
    collection do
      post :preview
    end
  end

  root 'api_hosts#index'
end
