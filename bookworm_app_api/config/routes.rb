Rails.application.routes.draw do
  resources :books
  resources :profiles

  resources :users do                                                            
    collection do                                                                
      post '/login', to: 'users#login'
      get '/auto_login', to: 'users#auto_login'                                  
    end                                                                          
  end       
                                
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
