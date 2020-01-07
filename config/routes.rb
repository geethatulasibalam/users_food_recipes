Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, path: '', path_names: { sign_up: 'signup', sign_in: 'signin', sign_out: 'signout'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dishes#index"
  post 'dishes/search', to: 'dishes#search'
  get 'dishes/autocomplete', to:'dishes#autocomplete'
  resources :dishes do
  	resources :reviews
  end
end
