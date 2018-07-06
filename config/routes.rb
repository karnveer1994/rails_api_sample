Rails.application.routes.draw do
  root 'api/group_events#index'
  
  namespace :api do
    resources :group_events, :defaults => { :format => 'json' } do
      collection do 
        get :published
        get :unpublished
        get :deleted
      end
    end
  end
end