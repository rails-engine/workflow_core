# frozen_string_literal: true

class Transitions::SimpleMerge < Transition
  def fire(token)
    p = output_places.first # assume only one output place
    # return unless p.tokens.size.zero?

    token.completed!
    # TODO: consider if status are not completed
    completed_tokens =
      input_places
        .includes(:tokens).where(workflow_tokens: {instance_id: token.instance_id})
        .map(&:tokens).flatten.select(&:completed?)
    if completed_tokens.size == 1
      next_token = p.tokens.create! previous: token, type: "Token",
                                    instance: token.instance, workflow: workflow
      auto_forward(next_token)
    end
  end

  def auto_forwardable?
    true
  end

  def options_configurable?
    false
  end
end
