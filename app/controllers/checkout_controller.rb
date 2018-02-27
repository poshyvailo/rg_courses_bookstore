class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def update

  end

  def show
    @order = current_order
    # case step
    #   when :find_friends
    #     @friends = @user.find_friends
    # end
    render_wizard
  end
end