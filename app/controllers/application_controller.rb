class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_class?

  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end
end
