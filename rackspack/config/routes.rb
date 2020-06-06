require 'sidekiq'
require 'sidekiq/web'
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
 [username, password] == ["ashish.mits.gwl@gmail.com","amg@123"]
end
  
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  resources :members, except: [:destroy]
  devise_for :users
  root to: 'members#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
