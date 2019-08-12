# frozen_string_literal: true

class WorkflowInstance < WorkflowCore::WorkflowInstance
  belongs_to :creator, class_name: "User"

  after_create :auto_create_start_token!

  private

    def auto_create_start_token!
      tokens.create! place: workflow.start_place,
                     workflow: workflow,
                     type: "Token",
                     assignable: creator
    end
end
