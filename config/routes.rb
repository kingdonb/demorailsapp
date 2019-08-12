Rails.application.routes.draw do
  get 'example/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/healthz', to: proc { [200, {}, ['']] }
  get '/metrics', to: proc { [200, {}, ['']] }

  root 'example#index'
end
