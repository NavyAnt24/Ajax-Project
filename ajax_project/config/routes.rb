SecretShareAjax::Application.routes.draw do
  resources :users, :only => [:index, :create, :new, :show]
  resource :session, :only => [:create, :destroy, :new]

  root :to => "users#show"

  resources :users, :only => [] do
    resources :secrets, :only => [:new]
  end

  resources :friendships, :only => [:create, :destroy]

  resources :secrets, :only => [:create]

end
