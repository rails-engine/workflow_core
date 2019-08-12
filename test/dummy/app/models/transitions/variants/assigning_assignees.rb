# frozen_string_literal: true

module Transitions::Variants
  class AssigningAssignees < Transitions::Sequence
    serialize :options, Transitions::Options::AssigningAssignees

    def on_fire(token, transaction_options, **options)
      token.completed!

      place = output_places.first # assume only one output place
      if self.options.assign_to_creator?
        next_token = place.tokens.create! assignable: token.instance.creator,
                                          previous: token, type: "Token",
                                          instance: token.instance, workflow: workflow
        auto_forward(next_token, transaction_options, options)
      elsif self.options.assign_to_specific?
        assignees = User.where(id: self.options.assignee_user_ids).to_a
        assignees.each do |assignee|
          next_token = place.tokens.create! assignable: assignee,
                                            previous: token, type: "Token",
                                            instance: token.instance, workflow: workflow
          auto_forward(next_token, transaction_options, options)
        end
      elsif self.options.assign_to_inherited?
        next_token = place.tokens.create! assignable: token.assignable,
                                          previous: token, type: "Token",
                                          instance: token.instance, workflow: workflow
        auto_forward(next_token, transaction_options, options)
      else
        raise "Unsupported assign to #{options.assign_to}"
      end
    end

    def auto_forwardable?
      true
    end
  end
end
