Quickvote::Application.routes.draw do
  root to: 'polls#new'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :polls, only: [:new, :create] do
    resources :votes, only: [:update]
  end
  get '/:id_hash', to: "polls#show", as: :hashed_poll
end
