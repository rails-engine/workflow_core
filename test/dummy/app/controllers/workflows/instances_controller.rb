# frozen_string_literal: true

class Workflows::InstancesController < Workflows::ApplicationController
  before_action :set_instance, only: %i[show]

  # GET /workflows/1/instances
  def index
    @instances = @workflow.instances.all
  end

  # GET /workflows/1/instances
  def show
    @form = @workflow.form
    @virtual_model = @form.to_virtual_model
    @form_record = @virtual_model.load(@instance.payload)

    render layout: "workflow_instances"
  end

  # POST /workflows/1/instances
  def create
    @workflow.instances.create! type: "WorkflowInstance"

    redirect_to workflow_instances_url(@workflow), notice: "instance was successfully created."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_instance
    @instance = @workflow.instances.find(params[:id])
  end
end
