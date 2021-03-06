Rails.application.routes.draw do

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:new,:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'users#dashboard', as: :admin_root
  end
  constraints Clearance::Constraints::SignedOut.new do
    root to: 'sessions#new'
  end

  resources :staffs, controller: "staffs" do
    resources :contracts,
      controller: "contracts",
      only: [:new,:create,:edit,:update]
  end
  resources :departments, controller: "departments"
  get '/send_invitation/:id' => 'invites#send_invitation', :as => 'send_invitation' 
  match '/signup/:invite_code' => 'users#new', :as => 'redeem_invitation', via: [:get, :post]
  post '/staffs/:staff_id/contracts/:id/terminate' => 'contracts#terminate', :as => "contract_termination"
  post '/staffs/:staff_id/contracts/:id/activate' => 'contracts#activate', :as => "contract_activation"
  post 'filter_staff_by_contracts' => 'staffs#filter_staff_by_contracts', :as => 'filter_staff_by_contracts'

  get '/settings/:authority' => 'settings#show', as:'settings'
  post '/set_work_days' => 'settings#set_work_days', as:'set_work_days'
  post '/set_leave_type' => 'settings#set_leave_type', as:'set_leave_type'
  post '/load_calendar' => 'settings#load_calendar', as:'load_calendar'
  post '/holiday_history' => 'settings#holiday_history', as:'holiday_history'
  post '/holiday_update' => 'settings#holiday_update', as:'holiday_update'
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
