# frozen_string_literal: true

module WorkflowCore
  class Workflow < ApplicationRecord
    include WorkflowCore::Concerns::Models::Workflow

    self.table_name = "workflows"

    belongs_to :start_place, class_name: "WorkflowCore::Place", dependent: :destroy, optional: true

    has_many :transitions, class_name: "WorkflowCore::Transition", dependent: :destroy
    has_many :places, class_name: "WorkflowCore::Place", dependent: :destroy

    has_many :instances, class_name: "WorkflowCore::WorkflowInstance", dependent: :destroy
    has_many :tokens, class_name: "WorkflowCore::Token", dependent: :destroy
  end
end
