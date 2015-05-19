Rails.application.routes.draw do
  
  root 'home#index'
  
  # Main models
  resources :documents, :except => [:index]
  resources :people, :except => [:new, :index]
  resources :technologies, :except => [:index]
  resources :ideas, :except => [:index]
  
  # tags JSON only 
  resources :tags, :only => [:index], :defaults  => { :format  => 'json' }
  
  # People specific routes 
  get 'enterprise/new' => 'people#new', :type => 'enterprise'
  get 'freelance/new' => 'people#new', :type => 'freelance'
  
  # Search 
  get 'search' => 'search#index'
  get 'search/results' => 'search#results'
  get 'search/relationmodule' => 'search#relationmodule'
  get 'search/linkElements' => 'search#do_link_elements'
  get 'search/unlinkElements' => 'search#do_unlink_elements'

  # User interactions 
  get 'users/sign_in' => 'users#sign_in'
  get 'users/sign_out' => 'users#sign_out'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }#, :path => 'users', :path_names => { :sign_in => 'login', :sign_up => 'login', :sign_out => 'logout' }

  get 'home/gdrive' => 'home#test_gdrive'
  post 'home/uploadfile' => 'home#upload_file'
    
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
