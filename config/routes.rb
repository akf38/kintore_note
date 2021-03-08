Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
    resources :user_infos, only:[:index, :edit, :update, :destroy]
  end
  resources :records, only: [:index, :show, :edit, :update, :destroy, :create, :new] do
    resources :training_records, only: [:create, :update, :destroy]
  end
  post 'training_records/new_record_create' => 'training_records#new_record_create'
  resources :tweets, only: [:index, :show, :edit, :update, :create] do
    resources :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end

