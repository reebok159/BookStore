# frozen_string_literal: true

SimpleForm.setup do |config|
  config.label_text = proc { |label, _required| label.to_s }
  config.wrappers :custom, class: 'form-group',
                           error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :pattern

    b.use :label, class: 'control-label input-label'
    b.use :input, class: 'form-control'
    b.use :full_error, wrap_with: { tag: :span, class: 'help-block' }
  end
end
