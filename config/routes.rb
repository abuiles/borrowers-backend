Rails.application.routes.draw do
  namespace :api do
    resources :friends, except: [:new, :edit]
  end
end
