Rails.application.routes.draw do
  namespace :api do
    resources :movies
    delete 'movies', to: 'movies#destroy_all'
    get 'movies/recent', to: 'movies#recent'
    get 'movies', to: 'movies#search'
  end
end

