# frozen_string_literal: true

module Transitions::Variants
  class Decision < Transitions::ExclusiveChoice
    serialize :options, Transitions::Options::Decision

    def on_fire(token, transaction_options, **options)
      token.completed!

      if self.options.one_vote_pass?
        token.instance.tokens.where(workflow: workflow, place_id: token.place, status: "processing").update_all status: :terminated
      end

      next_place_id = self.options.actions.select do |action|
        token.payload["action"] == action.value
      end.first&.place_id
      raise "No suitable place id for action #{token.payload['action']}" unless next_place_id

      next_place = workflow.places.find(next_place_id)
      next_token = next_place.tokens.create! previous: token, type: "Token",
                                             instance: token.instance, workflow: workflow,
                                             assignable: token.assignable
      auto_forward(next_token, transaction_options, options)
    end

    def auto_forwardable?
      false
    end
  end
end
