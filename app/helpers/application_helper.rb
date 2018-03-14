module ApplicationHelper

  include OrderConcern
  include OrderItemConcern

  def categories
    @categories ||= Category.all
  end

  def cart_count_items
    @cart_count_items ||= order_items.count
  end

  def checkout_progress_bar
    content_tag(:ul, class: 'steps list-inline') do
      wizard_steps.collect.with_index do |every_step, index|
        step_class = "unfinished"
        step_class = "active"  if every_step == step
        step_class = "active" if past_step?(every_step)
        concat(
            content_tag(:li, class: "step #{step_class}") do
              step_number = past_step?(every_step) ? '🗸' : index + 1
              content_tag(:span, step_number, class: 'step-number') +
              content_tag(:span, every_step.to_s.capitalize, class: 'step-text hidden-xs')
            end
        )
        unless every_step == wizard_steps.last
          concat(content_tag(:li, nil, class: 'step-divider'))
        end
      end
    end
  end
end
