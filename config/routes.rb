Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :doctors, only: [:show] do
    resources :patients, controller: 'doctors/patients'
  end
  resources :doctor_patients
  resources :patients, only: [:index]
end
