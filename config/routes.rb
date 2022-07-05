Rails.application.routes.draw do
  resources :leases, only: [:create, :destroy, :index]
  resources :tenants
  resources :apartments

end
