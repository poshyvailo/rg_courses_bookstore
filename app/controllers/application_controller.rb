class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include OrderOperation

  protected

  def after_sign_in_path_for(resource)
    set_user_to_order
    root_url
  end
end
