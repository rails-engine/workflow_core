# frozen_string_literal: true

module WorkflowCore
  class Token < ApplicationRecord
    self.table_name = "workflow_tokens"

    belongs_to :instance,
               class_name: "WorkflowCore::WorkflowInstance"
    belongs_to :workflow

    belongs_to :place
    belongs_to :previous, optional: true,
               class_name: "WorkflowCore::Token"

    enum status: {
      processing: 0,
      completed: 1,
      failed: 2,
      unexpected: 3,
      terminated: 4
    }
  end
end
