class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include OrderConcern
  include OrderItemConcern

  def current_ability
    @current_ability ||= Ability.new(current_customer)
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      merge_orders
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      delete_order_from_cookie
      root_url
    end
  end
end
