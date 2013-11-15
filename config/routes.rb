CoachBase::Application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}

  resources :courses
  resources :schedule

end
