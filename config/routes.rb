Rails.application.routes.draw do
  # OAuth routes
  match 'oauth/callback' => 'oauths#callback', via: [:get, :post]
  match 'oauth/delete/:provider' => 'oauths#destroy', as: :delete_auth, via: [:get, :delete]
  get 'oauth/:provider' => 'oauths#auth', :as => :auth_at_provider


  # Registration routes
  get 'register' => 'registrations#new'
  post 'register' => 'registrations#create'
  get 'activate_user' => 'registrations#activate', as: :activate_user

  post 'reset_password' => 'reset_passwords#create', as: :reset_password_get
  get 'reset_password/:token' => 'reset_passwords#edit', as: :reset_password_token
  patch 'reset_password/:token' => 'reset_passwords#update'

  # Session routes
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'auth/current_user' => 'sessions#show'
  match 'logout' => 'sessions#destroy', via: [:get, :delete]

  # Page routes
  get 'pages/*url' => 'pages#show', :as => 'page_url'

  resources :news

  resources :blog_posts, :path => 'blog' do
    resources :comments, controller: :blog_comments, except: [:index, :show, :new]
  end

  resources :questions do
    collection do
      get 'f/mine' => 'questions#index', as: :my, defaults: { mine: true }
      get 'f/:filter' => 'questions#index', as: :filter
    end
    resources :answers, except: [:new]
  end

  resources :guest_posts, :path => 'guestbook', :except => [:show]

  get '/users/:id' => 'users#show', as: :show_user
  get '/user_groups' => 'user_groups#index'
  resource :profile, only:[:show, :edit, :update] do
    get 'skill_requests' => 'skill_requests#user_index', as: :skill_requests
    get 'drafts' => 'forum_drafts#index', as: :drafts
    post 'drafts/:type' => 'forum_drafts#create', as: :create_draft, defaults: {type: 'post'}
    delete 'drafts/:type/:id' => 'forum_drafts#delete', as: :draft, defaults: {type: 'post'}
    get 'roles' => 'current_roles#index', as: :roles
  end
  resources :delegations, only: [:create, :destroy, :update]

  # Chars routes
  resources :chars do
    collection do
      get :engine
    end
    member do
      post :small_update
      post 'request_skill/:skill_id' => 'skill_requests#create', as: :skill_request
    end
  end

  get '/get_chars/messages' => 'get_chars#messages', defaults: {format: :json}

  resources :char_avatars, only:[:create, :update, :destroy], defaults: {format: :json}

  # Forum routes
  get '/temple/viewtopic.php' => 'redirects/topic_redirects#show'
  get '/temple/viewforum.php' => 'redirects/forum_redirects#show'
  get '/journal/:journal/:page' => 'redirects/journal_redirects#show'

  resources :forums, path: 'temple', only:[:index, :show] do
    collection do
      resources :forum_reads, only: [:index, :create, :show]
      resource :move_topic, only: [:show, :update, :destroy, :create], controller: :move_topic
      post 'master_note' => 'master_notifications#create', as: :master_note
    end
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


  resources :journals, only: [:index, :show] do
    collection do
      get '/tag/:tag' => 'journal_tags#show', as: :tag
      get '/p/:page_id' => :page
    end
    member do
      get '/p/:page_id' => :page, as: :page
    end
  end

  scope '/directory', only: [:index, :show] do
    resources :stones, controller: 'directory', type: 'SprStone'
    resources :herbs, controller: 'directory', type: 'SprHerb'
  end

  namespace :mini_lists do
    get :news
    get :blog
  end


# Administration block
  scope '/admin' do
    resources :users, except: [:new, :create, :show]
    resources :chars, controller: 'admin_chars', except: [:new, :create], as: :admin_chars do
      put :accept
      put :approve
      put :decline
      put :restore
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
    resources :pages, controller: :admin_pages, except: [:new] do
      put '' => 'admin_pages#save_tree', on: :collection
    end
    resources :journals, controller: :admin_journals, except: [:new, :edit], as: :admin_journals do
      resources :pages, controller: :admin_journal_pages, except: [:index, :new, :edit] do
        delete ':image_id' => :destroy_image
        post :reset
      end
    end
    get '/logs' => 'logs#index', as: :logs
    get '/logs/:category' => 'logs#show', as: :log
    resources :mailings, except: [:edit, :update]
    namespace :statistics do
      resources :post_counts, only: [:index, :create]
    end
  end

  get '/journal_tags' => 'journal_tags#index', defaults: {format: :json}

  get '/proverb' => 'proverb#show'
  get '/weather' => 'weather#show'

  get '/ankets/profile.html' => 'redirects/char_redirects#show'

  root 'pages#show', root: true

  get '/*path' => 'pages#show', defaults: {url: '404'}

end
