class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include OrderConcern
  include OrderItemConcern

  protected

  def after_sign_in_path_for(resource)
    merge_orders
    root_url
  end

  def after_sign_out_path_for(resource)
    delete_order_from_cookie
    root_url
  end
end
