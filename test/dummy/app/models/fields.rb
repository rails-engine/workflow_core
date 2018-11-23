# frozen_string_literal: true

module Fields
  %w[
    text boolean decimal integer
    nested_form multiple_nested_form
  ].each do |type|
    require_dependency "fields/#{type}_field"
  end
end
