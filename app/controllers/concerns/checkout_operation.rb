module CheckoutOperation
  extend ActiveSupport::Concern

  included do
    def order_step
      current_order.order_step
    end

    def next_order_step
      order_step? && order_step != 'complete' ? steps[order_step_index.next] : steps.first
    end

    def order_step_index
      steps.index(order_step.to_sym)
    end

    def set_order_step
      params[:order] ||= {}
      params[:order][:order_step] = step
      params[:order][:order_step] = 'complete' if confirm_step?
    end

    def order_step?
      order_step.nil? ? false : true
    end

    def confirm_step?
      next_order_step == :confirm
    end

    def address_step?
      step == :address
    end

    def delivery_step?
      step == :delivery
    end

    def copy_billing_to_shipping
      params[:order][:shipping_address_attributes] = params[:order][:billing_address_attributes]
    end

    def use_billing_address?
      params[:use_billing_address]
    end

  end

end