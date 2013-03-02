class TurkerConstraint
  def initialize
    #todo - change calendar_match to whatever domain turks are directed to
    @turker_host_names = ['lvh.me', 'makemeeting.info']
  end
 
  def matches?(request)
    @turker_host_names.include?(request.host)
  end
end

class RegularUserConstraint
  def initialize
    @regular_host_names = ['localhost', 'herokuapp.com','meetings.zenlike.me']
  end
 
  def matches?(request)
    @regular_host_names.include?(request.host)
  end
end


Zenlike::Application.routes.draw do
  
  #########################################
  #this is for all of the Turk based stuff
  #########################################  
  
  #constraints TurkerConstraint.new do
  #  get 'meeting_thread_jobs' => 'meeting_thread_jobs#index', :as => 'meeting_thread_jobs'
  #  get 'meeting_thread_jobs/:id' => 'meeting_thread_jobs#show', :as => 'meeting_thread_job' 
  #  resources :calendar_guesses
  #end
  
  
  get 'meeting_thread_jobs' => 'meeting_thread_jobs#index', :as => 'meeting_thread_jobs'
  get 'meeting_thread_jobs/:id' => 'meeting_thread_jobs#show', :as => 'meeting_thread_job' 
  resources :calendar_guesses
    
  #########################################
  #this is for all the regular user type stuff
  #########################################  
  constraints RegularUserConstraint.new do
    
    #meetingthreads
    #  resources :meeting_threads, :except=> [:new] do
      resources :meeting_threads do
        collection do
          post 'from_sendgrid'
        end
      end

  end

  #########################################
  #common
  #########################################  

  root :to => "users#new"
    
  #users
  resources :users
  resources :turkers, :path => :users
  match 'users/:id' => 'users#show', :as => :account
  get "sign_up" => 'users#new', :as => 'sign_up'


  
  #sessions
  resources :sessions
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'log_in' => 'sessions#new', :as => 'log_in'
  
    
  match 'users/:id/verify/:confirmation_code' => 'users#verify', :as => :verify_user
    
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
