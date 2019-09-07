Rails.application.routes.draw do
  resources :goals
  root 'static_pages#about'
end
