# frozen_string_literal: true

module Transitions
  %w[
    sequence
    start end
    parallel_split synchronization
    exclusive_choice simple_merge
  ].each do |type|
    require_dependency "transitions/#{type}"
  end

  %w[
    user_task assigning_assignees decision
  ].each do |type|
    require_dependency "transitions/variants/#{type}"
  end
end
