Rails.application.routes.draw do
  resources :tickets, only: %i[index show create update]
end
