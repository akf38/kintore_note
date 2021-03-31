Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :omniauth_callbacks => 'users/omniauth_callbacks',
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get '/privacy' => 'homes#privacy'
  get '/term'    => 'homes#term'
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
      post :soft_delete
    end
    resources :trainings, only: [:show]
    resources :user_infos, only: [:index, :edit, :update, :destroy]
  end
  resources :records do
    resources :training_records, only: [:create, :update, :destroy]
  end
  post 'training_records/new_record_create' => 'training_records#new_record_create'
  resources :tweets, only: [:index, :show, :edit, :update, :create, :destroy] do
    resources :favorites, only: [:create, :destroy]
    resources :tweet_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :parts, only: [] do
    resources :trainings, only: [:index]
  end
  resources :notifications, only: :index do
    collection do
      delete :destroy_all
    end
 end
end
