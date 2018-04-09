SimpleForm.setup do |config|
  config.wrappers :default,
                  class: 'form-group',
                  hint_class: :field_with_hint,
                  error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    ## Inputs
    b.use :label, class: 'control-label input-label'
    b.use :input, class: 'form-control'
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :full_error, wrap_with: { tag: :span, class: 'help-block' }
  end

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.button_class = 'btn'
  config.error_notification_tag = :div
  config.error_notification_class = 'error_notification'
  config.label_text = lambda { |label, required, explicit_label| "#{label}" }
  config.default_form_class = 'general-form'
  config.browser_validations = false
  config.boolean_label_class = 'checkbox'
end
