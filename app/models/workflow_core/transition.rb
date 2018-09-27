# frozen_string_literal: true

module WorkflowCore
  class Transition < ApplicationRecord
    self.table_name = "workflow_transitions"

    belongs_to :workflow

    has_many :input_places, dependent: :nullify,
             foreign_key: "output_transition_id", class_name: "WorkflowCore::Place"
    has_many :output_places, dependent: :destroy,
             foreign_key: "input_transition_id", class_name: "WorkflowCore::Place"

    def fire(_token)
      raise NotImplementedError
    end
  end
end
