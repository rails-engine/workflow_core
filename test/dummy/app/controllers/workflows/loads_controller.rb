# frozen_string_literal: true

class Workflows::LoadsController < Workflows::ApplicationController
  # GET /workflows/1/load
  def show; end

  # PATCH/PUT /workflows/1/load
  def update
    bpmn_xml = permitted_params[:bpmn_xml].presence || permitted_params[:bpmn_file]&.read
    @workflow.load_from_bpmn!(bpmn_xml)

    redirect_to workflow_url(@workflow), notice: "Workflow definition was successfully imported."
  end

  private

    # Only allow a trusted parameter "white list" through.
    def permitted_params
      params.permit(:bpmn_xml, :bpmn_file)
    end
end
