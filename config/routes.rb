Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'home', to: 'pages#index', as: 'home'

  authenticated :user do
    root 'logins#index'
    get 'success' => 'logins#callback_success'

    resources :logins
    resources :accounts
    post 'create_login', to: 'logins#create_login', as: 'create_login'
    get 'list_logins', to: 'logins#list_logins', as: 'list_logins'
    post 'save_login', to: 'logins#save_login', as: 'save_login'
    delete 'remove_login', to: 'logins#remove_login', as: 'remove_login'
    put 'reconnect_login', to: 'logins#reconnect_login', as: 'reconnect_login'
    put 'refresh_login', to: 'logins#refresh_login', as: 'refresh_login'
  end
  root to: "pages#index"
end
