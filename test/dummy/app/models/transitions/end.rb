# frozen_string_literal: true

class Transitions::End < Transition
  def fire(token)
    p = output_places.first # assume only one output place

    token.completed!
    p.tokens.create! status: :completed,
                     previous: token, type: "Token",
                     workflow_id: workflow_id, instance_id: token.instance_id
    token.instance.completed!
  end

  def auto_forwardable?
    true
  end

  def options_configurable?
    false
  end
end
