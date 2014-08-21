Rails.application.routes.draw do
  namespace :api do
    resources :articles, except: [:new, :edit]
    resources :friends,  except: [:new, :edit]
  end
end
