Rails.application.routes.draw do

  resources :charges

  resources :checkouts

  resources :categories, only: [:index, :show]

  resources :ads do
    member do
      get :toggle_status
      post :create_address
    end
  end

  get 'ads/:id/info', to: 'ads#info', as: 'info'
  get 'ads/:id/details', to: 'ads#details', as: 'ad_detail'
  # get 'ads/:id/create_address', to: "ads#checkout", as: 'checkout'


  #Overides show path in 'resourches :users'
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/sold/:id', to: 'charges#sold', as: 'sold'

  resources :users, except: [:new]

  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }, path: '', path_names: { sign_in: 'login',
  sign_out: 'logout', sign_up: 'register'}
  root to: "ads#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
