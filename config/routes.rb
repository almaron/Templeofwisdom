Rails.application.routes.draw do

  #OAuth routes
  match "oauth/callback" => "oauths#callback", via: [:get, :post]
  match "oauth/delete/:provider" => "oauths#destroy", as: :delete_auth, via: [:get, :delete]
  get "oauth/:provider" => "oauths#auth", :as => :auth_at_provider


  #Registration routes
  get "register" => "registrations#new"
  post "register" => "registrations#create"
  get "activate_user" => "registrations#activate", as: :activate_user

  #Session routes
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get 'auth/current_user' => 'sessions#get_current_user'
  match "logout" => "sessions#destroy", via: [:get, :delete]

  # Page routes
  resources :pages, :except => [:show]
  get "pages/:url" => "pages#show", :as => "page_url"

  resources :news

  resources :blog_posts, :path => "blog" do
    resources :comments, controller: :blog_comments, except: [:index, :show, :new]
  end

  resources :guest_posts, :path => "guestbook", :except => [:show]

  resources :users, except: [:new,:create]
  resource :profile, only:[:show, :edit, :update]
  resources :chars
  resources :delegations, only: [:create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'


  root 'pages#show', root: true

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
