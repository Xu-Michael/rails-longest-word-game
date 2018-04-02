Rails.application.routes.draw do
  # get 'score', to: 'games#score', as: :score
  get 'new', to: 'games#new', as: :new
  post 'score', to: 'games#score', as: :score
end
