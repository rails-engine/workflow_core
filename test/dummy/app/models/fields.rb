# frozen_string_literal: true

module Fields
  %w[
  text boolean decimal integer
  ].each do |type|
    require_dependency "fields/#{type}_field"
  end
end
