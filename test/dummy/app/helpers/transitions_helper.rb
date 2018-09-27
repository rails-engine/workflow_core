# frozen_string_literal: true

module TransitionsHelper
  def options_for_transition_types(selected: nil)
    options_for_select(Transition.descendants.map { |klass| [klass.model_name.human, klass.to_s] }, selected)
  end
end
