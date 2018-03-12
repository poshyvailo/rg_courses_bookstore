class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include OrderConcern

  protected

  def after_sign_in_path_for(resource)
    # set_user_to_order
    merge_orders
    root_url
  end

  def after_sign_out_path_for(resource)
    delete_order_from_cookie
    root_url
  end
end
