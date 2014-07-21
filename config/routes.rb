Coworking::Application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root to: 'pages#front' 

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#delete"
  get "/register", to: "users#new"
  get "/home", to: 'spaces#index'
  get "/deactivate", to: 'users#deactivate'

  get "/forgot_password", to: "forgot_passwords#new"
  get "/reset_confirmation", to: "forgot_passwords#reset"
  
  #get "/reset_forgot_password", to: "forgot_passwords#reset_password"
  get "/invalid_token", to: "reset_passwords#invalid_token"

  resources :spaces, except: [:destroy] do
    # to cater for posts/2/vote 
    member do
      post :vote
    end
    collection do
      get :search, to: "spaces#search"
    end
    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
  end

  resources :users, except: [:destroy]
  resources :categories, only: [:show]
  resources :forgot_passwords, only: [:create]
  resources :reset_passwords, only: [:show, :create]

  namespace :admin do
    resources :categories, only: [:new, :create]
  end


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
