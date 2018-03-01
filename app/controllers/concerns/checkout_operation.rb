module CheckoutOperation
  extend ActiveSupport::Concern

  included do
    def order_step
      current_order.order_step
    end

    def next_order_step
      order_step? ? steps[order_step_index.next] : steps.first
    end

    def order_step_index
      steps.index(order_step.to_sym)
    end

    def set_order_step
      params[:order][:order_step] = step
      params[:order][:order_step] = 'complete' if [:confirm, :complete].include? step
    end

    def order_step?
      order_step.nil? ? false : true
    end

    def confirm_step?
      next_order_step == :confirm
    end

  end

end