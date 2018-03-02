module CheckoutOperation
  extend ActiveSupport::Concern

  included do

    def order_step?
      order_step.nil? ? false : true
    end

    def order_step_index
      steps.index(order_step.to_sym)
    end

    def next_order_step
      order_step? ? steps[order_step_index.next] : steps.first
    end

    def next_order_step_confirm?
      next_order_step == :confirm
    end

    def current_step_address?
      step == :address
    end

    def current_step_delivery?
      step == :delivery
    end

  end

end