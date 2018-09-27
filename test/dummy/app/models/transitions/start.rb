# frozen_string_literal: true

class Transitions::Start < Transition
  # http://workflowpatterns.com/patterns/control/basic/wcp1.php

  def fire(token)
    p = output_places.first # assume only one output place

    token.completed!
    next_token = p.tokens.create! previous: token, type: "Token",
                                  instance: token.instance, workflow: workflow
    auto_forward(next_token)
  end
end
