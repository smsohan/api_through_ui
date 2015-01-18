Rails.application.routes.draw do
  devise_for :users
  get 'api_action_descriptions/create'

  get 'pages/how_it_works', as: :how_it_works
  get 'pages/about', as: :about

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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'api_hosts#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
