Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'
  resources 'cases' do
    collection do
      get 'tempered_glass'
      get 'filter_cases'
      get 'mobile_filter_cases'
    end
  end

  namespace :admin do
    resources 'cases' do
      get 'get_orders'
      get 'categories'
      collection do
        post 'toggle_top_sales'
        post 'toggle_is_available'
      end
    end
    resources 'orders'
    get 'change_chart_type/:chart_type', to: 'orders#change_chart_type'
  end
end
