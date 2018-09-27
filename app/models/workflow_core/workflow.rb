# frozen_string_literal: true

module WorkflowCore
  class Workflow < ApplicationRecord
    self.table_name = "workflows"

    has_one :start_place, class_name: "WorkflowCore::Place", dependent: :destroy

    has_many :transitions, class_name: "WorkflowCore::Transition", dependent: :destroy
    has_many :places, class_name: "WorkflowCore::Place", dependent: :destroy

    has_many :instances, class_name: "WorkflowCore::WorkflowInstance", dependent: :destroy
    has_many :tokens, class_name: "WorkflowCore::Token", dependent: :destroy
  end
end
