Rails.application.routes.draw do

  devise_for :users
  # You can have the root of your site routed with "root"
  root 'welcome#index'


  resources :users
  resources :scenarios

  get 'welcome/index'
  get 'admin/index'
  resources :admin

  resources :events do
    resources :event_hosts
    resources :gm_list
    resources :gms_by_scenario
    resources :table_assignment
    resources :event_receipt
    resources :gm_list, only: :index
    resources :gms_by_scenario, only: :index
    resources :tables_by_session, only: :index
    resources :table_assignment, only: :index
    resources :tickets, only: :index

    resources :user_events do
      collection do
        get 'search'
        get 'show_since'
      end
      resources :additional_payments do
      # resources :additional_payments, shallow: true do
        resources :additional_payment_payment, only: [:new, :create]
      end
      resources :registration_payment, only: [:new, :create]
    end
    resources :sessions do
      resources :tables do
        resources :registration_tables do
          resources :table_payment, only: [:new, :create]
        end
        resources :game_masters
      end
    end
  end


  # message stuffs
  get 'contact', to: 'contact#new', as: 'contact'
  post 'contact', to: 'contact#create'
  resources :contact

  get 'admin_email', to: 'admin_email#new', as: 'admin_email'
  post 'contact', to: 'admin_email#create'
  resources :admin_email

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".
end
