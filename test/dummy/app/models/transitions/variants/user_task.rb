# frozen_string_literal: true

module Transitions::Variants
  class UserTask < Transitions::Sequence
    serialize :options, Transitions::Options::UserTask

    def on_fire(token, transaction_options, **options)
      token.completed!
      token.instance.tokens.where(workflow: workflow, place_id: token.place, status: "processing").update_all status: :terminated

      place = output_places.first # assume only one output place
      next_token = place.tokens.create! previous: token, type: "Token",
                                        instance: token.instance, workflow: workflow,
                                        assignable: token.assignable
      auto_forward(next_token, transaction_options, options)
    end
  end
end
