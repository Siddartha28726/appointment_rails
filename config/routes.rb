Rails.application.routes.draw do
  resources :doctors
  resources :patients
  resources :medical_appointments
end
