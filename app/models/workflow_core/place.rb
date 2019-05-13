# frozen_string_literal: true

module WorkflowCore
  class Place < ApplicationRecord
    include WorkflowCore::Concerns::Models::Place

    self.table_name = "workflow_places"

    belongs_to :workflow

    belongs_to :input_transition, optional: true, foreign_key: "input_transition_id",
                                  class_name: "WorkflowCore::Transition"
    belongs_to :output_transition, optional: true, foreign_key: "output_transition_id",
                                   class_name: "WorkflowCore::Transition"

    has_many :tokens
  end
end
