Gullery::Application.routes.draw do

  root :to => 'projects#index'

  match 'signup', :to => 'account#signup'#, :as => "signup"
  match 'login', :to => "account#login"
  match 'logout', :to => "account#logout"

  match 'paintings', :to => "projects#show", :defaults => {:id => 1}
  match 'photography', :to => "projects#show", :defaults => {:id => 2}
  match 'paintings/rss', :to => "projects#rss", :as => "paintings_rss", :defaults => {:id => 1}
  match 'photography/rss', :to => "projects#rss", :as => "photography_rss", :defaults => {:id => 2}

  resources :projects do
    post 'sort', on: :collection
  end

  #match 'assets/:id' => 'assets#show'

  match '/account/update_description' => 'account#update_description', :as => :account


  match 'feed', :to => "projects#feed"

  resources :assets

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
