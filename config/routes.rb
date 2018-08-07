Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'
  resources 'cases' do
    get 'categories'
    collection do
      get 'tempered_glass'
      get 'filter_cases'
      get 'mobile_filter_cases'
    end
  end

  namespace :admin do
    resources 'cases' do
      collection do
        post 'toggle_top_sales'
        post 'toggle_is_available'
      end
    end
    resources 'orders'
  end
end
