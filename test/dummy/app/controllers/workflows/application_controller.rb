# frozen_string_literal: true

class Workflows::ApplicationController < ApplicationController
  layout "workflows"

  before_action :set_workflow

  protected

    # Use callbacks to share common setup or constraints between actions.
    def set_workflow
      @workflow = Workflow.find(params[:workflow_id])
    end
end
