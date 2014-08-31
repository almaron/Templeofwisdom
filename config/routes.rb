Rails.application.routes.draw do

  get 'admin_pages/index'

  get 'admin_pages/show'

  get 'admin_pages/update'

  get 'admin_pages/destroy'

  # OAuth routes
  match 'oauth/callback' => 'oauths#callback', via: [:get, :post]
  match 'oauth/delete/:provider' => 'oauths#destroy', as: :delete_auth, via: [:get, :delete]
  get 'oauth/:provider' => 'oauths#auth', :as => :auth_at_provider


  # Registration routes
  get 'register' => 'registrations#new'
  post 'register' => 'registrations#create'
  get 'activate_user' => 'registrations#activate', as: :activate_user

  # Session routes
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'auth/current_user' => 'sessions#get_current_user'
  match 'logout' => 'sessions#destroy', via: [:get, :delete]

  # Page routes
  get 'pages/*url' => 'pages#show', :as => 'page_url'

  resources :news

  resources :blog_posts, :path => 'blog' do
    resources :comments, controller: :blog_comments, except: [:index, :show, :new]
  end

  resources :guest_posts, :path => 'guestbook', :except => [:show]

  get '/users/:id' => 'users#show', as: :show_user
  get '/user_groups' => 'user_groups#index'
  resource :profile, only:[:show, :edit, :update] do
    get 'skill_requests' => 'skill_requests#user_index', as: :skill_requests
  end
  resources :delegations, only: [:create, :destroy]

  # Chars routes
  resources :chars do
    collection do
      get :engine
    end
    member do
      post :small_update
      post "request_skill/:skill_id" => "skill_requests#create", as: :skill_request
    end
  end

  # Forum routes
  resources :forums, path: 'temple', only:[:index, :show] do
    resources :topics, path: 't', controller: 'forum_topics' do
      resources :posts, path: 'p', controller: 'forum_posts'
    end
  end

  get '/roles/:id' => 'roles#show', as: :show_role
  resources :role_apps

  resources :notifications, only: [:index, :show, :destroy]
  resources :messages do
    collection do
      get :outbox
      get 'inbox'=>'messages#index', as: :inbox
    end
    member do
      get :reply
    end
  end

  get '/skills/:id' => 'skills#show', as: :skill_show, id: /\d+/
  get '/skills/:skill_type' => 'skills#public_index', as: :skills_list, skill_type: /magic|phisic/

# Administration block
  scope '/admin' do
    resources :users, except: [:new, :create, :show]
    resources :chars, controller: 'admin_chars', except: [:new, :create], as: :admin_chars do
      put :accept
      put :approve
      put :decline
    end
    resources :forums, controller: 'admin_forums' do
      collection do
        put '' => 'admin_forums#save_tree'
      end
    end
    resources :configs, except: [:show, :new, :edit]
    resources :roles
    resources :skills, except: [:show, :edit, :new]
    resources :skill_requests, only: [:index, :update, :destroy]
    resources :ips, only: :index
    resources :pages, controller: :admin_pages, only: [:index, :show, :update, :destroy]
  end

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
  #   resources :system_posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
