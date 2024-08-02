Rails.application.routes.draw do
  root 'articles#index'

  namespace :api do
    get 'articles/index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
