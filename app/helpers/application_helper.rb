module ApplicationHelper

  include OrderOperation

  def categories
    Category.all
  end

  def cart_count_items
    @order = current_order.order_items.count
  end

  def tutorial_progress_bar
    content_tag(:ul, class: 'steps list-inline') do
      wizard_steps.collect do |every_step|
        step = "unfinished"
        step = "active"  if every_step == step
        step = "finished" if past_step?(every_step)
        concat(
            content_tag(:li, class: "steps #{step}") do
              content_tag(:span)
              link_to every_step.to_s, wizard_path(every_step)
            end
        )
      end
    end
  end
end
