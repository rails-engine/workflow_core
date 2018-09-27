# frozen_string_literal: true

class Transitions::ParallelSplit < Transition
  def fire(token)
    token.completed!
    output_places.each do |p|
      next_token = p.tokens.create! previous: token, type: "Token",
                                    instance: token.instance, workflow: workflow
      auto_forward(next_token)
    end

    def auto_forwardable?
      true
    end

    def options_configurable?
      false
    end
  end
end
