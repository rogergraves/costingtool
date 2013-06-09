Costingtool::Application.routes.draw do
  resources :jobs
  root :to => "jobs#index"
  resources :press_jobs, :only => [:index, :new, :create, :show, :update]
  resources :cost_analyses, :only => [:index, :update]
  resources :dashboards, :only => [:index]
  resources :roi, :only => [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => {:confirmations => 'confirmations', :registrations => 'registrations', :sessions => 'sessions'}
  ActiveAdmin.routes(self)

  devise_scope :user do
    put "/confirm" => "confirmations#confirm"
    post "/users" => "registrations#create"
  end

  match 'jobs/empty_basket' => 'jobs#empty_basket'
  match 'press_jobs/log_presses' => 'press_jobs#log_presses'



end
