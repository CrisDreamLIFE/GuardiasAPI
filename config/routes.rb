Rails.application.routes.draw do
  resources :services do
    resources :weeks do
      resources :days do
        resources :blocks
      end
    end
  end
  resources :engineers
  resources :availabilities
  resources :weeks do
    member do
      post :assign_shifts
    end
  end
  
   get 'weeks/:id/show_blocks_with_availability', to: 'weeks#show_blocks_with_availability'
  # resources :services do
  #   resources :weeks do
  #     member do
  #       get :show_blocks_with_availability
  #     end
  #     resources :days do
  #       resources :blocks
  #     end
  #   end
  # end
  
  # resources :engineers
  # resources :availabilities
  
  # resources :weeks do
  #   member do
  #     post :assign_shifts
  #   end
  # end
  get "up" => "rails/health#show", :as => :rails_health_check
end
