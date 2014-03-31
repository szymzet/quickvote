Quickvote::Application.routes.draw do
  root to: 'polls#new'

  resources :polls, only: [:new, :create, :show]
end
