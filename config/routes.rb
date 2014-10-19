Rails.application.routes.draw do
  namespace :api do
    resources :articles, except: [:new, :edit]
    resources :friends,  except: [:new, :edit]
    namespace :v2 do
      resources :friends,  except: [:new, :edit]
      resources :articles, except: [:new, :edit]
    end
    namespace :v3 do
      resources :friends,  except: [:new, :edit]
      resources :articles, except: [:new, :edit]
    end
    namespace :v4 do
      resources :friends,  except: [:new, :edit]
      resources :articles, except: [:new, :edit]
    end
  end
end
