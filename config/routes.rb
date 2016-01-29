Rails.application.routes.draw do


  comfy_route :blog_admin, :path => '/admin'
  comfy_route :blog, :path => '/blog'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :tipsters, controllers: {
    registrations: 'tipsters/registrations',
    sessions: 'tipsters/sessions'
  }
  
  devise_for :users, controllers: {
        sessions: 'users/sessions'
  }
      
  root 'landing_pages#index'

  namespace :tdashboard do
    resources :leagues do
      resources :matches
    end
    resources :orders
    resources :picks
    get '/' => "base#index"
    get 'todaygame' => "matches#todaygame"
    
    resources :tipsters, only: [:index, :show] do
      collection do
        put :view_notifications
      end
    end
  end
  
  namespace :dashboard do
    resources :tipsters do
      member do
        get :follow
        get :unfollow
      end
    end
    get '/' => "base#index"
    get '/mytipsters' => "tipsters#mytipsters"
  end
  
  resources :activities
  
#mount Monologue::Engine, at: '/blog'

comfy_route :cms_admin, :path => '/admin'

# Make sure this routeset is defined last
comfy_route :cms, :path => '/', :sitemap => false

end
