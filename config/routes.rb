Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'
  resources 'cases' do
    collection do
      get 'filter_cases'
    end
  end

  namespace :admin do
    resources 'cases' do
      collection do
        post 'toggle_top_sales'
        post 'toggle_is_available'
      end
    end
  end
end
