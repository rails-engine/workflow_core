# frozen_string_literal: true

module WorkflowCore
  class WorkflowInstance < ApplicationRecord
    include WorkflowCore::Concerns::Models::WorkflowInstance

    self.table_name = "workflow_instances"

    belongs_to :workflow
    has_many :tokens, foreign_key: "instance_id", dependent: :destroy

    enum status: {
      processing: 0,
      completed: 1,
      failed: 2,
      unexpected: 3,
      terminated: 4
    }

    serialize :payload
  end
end
