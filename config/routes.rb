Knock4::Application.routes.draw do

  get "groups/index"
  get "groups/new"
  get "groups/show"
  get "events/index"
  get "events/new"
  get "events/show"
  get "venues/index"
  get "venues/new"
  get "venues/show"
  get "interests/index"
  get "interests/new"
  get "interests/show"

  devise_for :knockers, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }
  resources :knockers, :only => [:index] do
    member do
      get :favourite_knockers, :favourited_knockers
    end
    resources :posts
    resource :profile, only: [:show, :edit, :update] 
    resources :knocker_venues
    resources :knocker_interests
    resources :group_members
    resources :event_attendances
  end

  resources :venues do
      resources :posts
      resources :interests, controller: 'venue_interests'
      resources :venue_interests
      resources :knocker_venues
      resources :group_venues
      resources :event_venues
  end

  resources :groups do
      resources :posts
      resources :group_venues
      resources :group_events
      resources :group_members
      resources :groups_interests
  end

  resources :events do
      resources :posts
      resources :event_venues
      resources :event_attendances
      resources :group_events
      resources :event_interests
  end

  resources :interests do
      resources :posts
  end

  resources :hypes, only: [:create, :destroy]
  resources :favouriteknockers, only: [:create, :destroy]
  resources :knocker_interests, only: [:create, :destroy]
  resources :knocker_venues, only: [:create, :destroy]
  resources :venue_interests, only: [:create, :destroy]
  resources :event_attendances, only: [:create, :destroy]
  resources :event_venues, only: [:create, :destroy]
  resources :group_events, only: [:create, :destroy]
  resources :group_members, only: [:create, :destroy]
  resources :group_venues, only: [:create, :destroy]
  resources :groups_interests, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy]
  resources :availabilities
  resources :messages do
    member do
      post :new
    end
  end
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
   collection do
      get :trashbin
      post :empty_trash
   end
  end
  
  root 'static_pages#home'
  devise_scope :knocker do
    get "/signup", to: 'devise/registrations#new'
    get "/signin", to: 'devise/sessions#new'
    get "/login", to: 'devise/sessions#new'
    delete "/signout", to: 'devise/sessions#destroy'
    delete "/logout", to: 'devise/sessions#destroy'
  end

  get '/venues/:id/edit_interests' => 'venues#edit_interests', as: 'venue_edit_interests'
  post '/venues/:id/update_interests' => 'venues#update_interests', as: 'venue_update_interests'
  delete '/venues/:id/update_interests' => 'venues#delete_interests', as: 'venue_delete_interests'
  get '/profile' => 'profiles#show', as: 'profile'
  get '/knockers/:id' => 'knockers#show', as: 'knocker'
  get '/knockers' => 'knockers#index', as: 'knocker_index'
  get '/calendar' => 'events#calendar', as: 'calendar'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  

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
