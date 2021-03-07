Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  resources :users, only: [:show, :edit, :update] do
    resources :user_infos, only:[:index, :edit, :update, :destroy]
  end
  resources :records, only: [:index, :show, :edit, :update, :destroy, :create, :new] do
    resources :training_records, only: [:create, :update, :destroy]
  end
end

