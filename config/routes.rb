Beta1::Application.routes.draw do
  
  get "products/index"
  get "karvy/index"
  get "camsfeeds/index"
  get "setup/c80"
  get "setup/rgess"
  get "setup/bonds"
  get "setup/emergency"
  get "setup/gold"
  get "setup/justinvest"
  get "setup/house"
  get "setup/marriage"
  get "setup/education"
  get "transactions/s"
  post "transactions/s"
  get "transactions/holdings"
  get "transactions/ru"
  post "transactions/ru"
  post "transactions/confirmation"
  get "banks/mandate"
  resources :visitors
  resources :analyses
  resources :taxsavings
  resources :dashboards do 
    collection do
      get :investment
    end
  end
  resources :funds 
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resource :kyc
  resources :banks
  resources :transactions do 
    collection do
      post :create_multiple

    end
  end


  resources :camsfeeds do 
    collection do 
      post :import
    end
  end

  resources :products do
 collection {post :import}
  end


  get "static_pages/index"
  get "static_pages/home"
  get "static_pages/whyus"
  get "static_pages/aboutus"
  get "static_pages/setup"
  get "static_pages/productpage"
  get "static_pages/download_pdf1"
  get "static_pages/download_pdf2"
  get "static_pages/download_pdf3"
  get "static_pages/download_pdf4"
  get "static_pages/video"
  get "dashboards/show"
  get "static_pages/videotreasure"
  get "static_pages/dashboard"

  root :to => 'static_pages#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
