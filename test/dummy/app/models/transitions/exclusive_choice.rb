# frozen_string_literal: true

class Transitions::ExclusiveChoice < Transition
  serialize :options, Transitions::Options::ExclusiveChoice

  def fire(token)
    instance = token.instance

    next_place_id = options.conditions.select do |condition|
      r = ScriptCore.run input: {payload: instance.payload},
                         sources: [["expression", "@output = #{condition.condition_expression}"]]
      if r.errors.any?
        raise r.errors.map(&:message).join("; ")
      end
      r.output
    end.first&.place_id || options.default_next_place_id
    next_place = workflow.places.find(next_place_id)

    token.completed!

    next_token = next_place.tokens.create! previous: token, type: "Token",
                                           instance: token.instance, workflow: workflow
    auto_forward(next_token)
  end

  def auto_forwardable?
    false
  end
end
