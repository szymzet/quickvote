Quickvote::Application.routes.draw do
  root to: 'polls#new'

  resources :polls, only: [:new, :create] do
    resources :votes, only: [:update]
  end
  get '/:id_hash', to: "polls#show", as: :hashed_poll
end
