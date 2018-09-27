# frozen_string_literal: true

module Places
  %w[
  start end
  ].each do |type|
    require_dependency "places/#{type}_place"
  end
end
