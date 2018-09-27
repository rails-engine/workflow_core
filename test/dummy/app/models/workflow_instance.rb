# frozen_string_literal: true

class WorkflowInstance < WorkflowCore::WorkflowInstance
  after_create :auto_create_start_token!

  private

  def auto_create_start_token!
    tokens.create! place: workflow.start_place,
                   workflow: workflow,
                   type: "Token"
  end
end
