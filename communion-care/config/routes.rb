Rails.application.routes.draw do
  # communion-care.com/api/v1/providers
  namespace :api do 
    namespace :v1 do 
      resources :providers
      resources :customers
      resources :appointments
    end
  end
end
