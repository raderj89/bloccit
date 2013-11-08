Bloccit::Application.routes.draw do
  
  devise_for :users
  
  resources :topics

  resources :posts

  match "about" => 'welcome#about', via: :get

  root to: 'welcome#index'
end
