# frozen_string_literal: true

module WorkflowCore
  class Transition < ApplicationRecord
    self.table_name = "workflow_transitions"

    belongs_to :workflow

    has_many :input_places, dependent: :nullify,
             foreign_key: "output_transition_id", class_name: "WorkflowCore::Place"
    has_many :output_places, dependent: :destroy,
             foreign_key: "input_transition_id", class_name: "WorkflowCore::Place"

    def fire(token, transaction_options: {requires_new: true}, **options)
      transaction(**transaction_options) do
        on_fire(token, transaction_options, options)
      end
    rescue => ex
      rescue_fire_error ex
    end

    protected

    def on_fire(_token, _transaction_options, **_options)
      raise NotImplementedError
    end

    def rescue_fire_error(ex)
      raise ex
    end
  end
end
