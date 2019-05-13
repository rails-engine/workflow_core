# frozen_string_literal: true

class WorkflowsController < ApplicationController
  layout "application"

  before_action :set_workflow, only: %i[show edit update destroy]

  # GET /workflows
  def index
    @workflows = Workflow.all
  end

  # GET /workflows/new
  def new
    @workflow = Workflow.new
  end

  # GET /workflows/1
  def show
    render layout: "workflows"
  end

  # GET /workflows/1/edit
  def edit; end

  # POST /workflows
  def create
    @workflow = Workflow.new(workflow_params)

    if @workflow.save
      redirect_to workflow_url(@workflow), notice: "workflow was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /workflows/1
  def update
    if @workflow.update(workflow_params)
      redirect_to workflow_url(@workflow), notice: "workflow was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /workflows/1
  def destroy
    @workflow.destroy
    redirect_to workflows_url, notice: "workflow was successfully destroyed."
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_workflow
      @workflow = Workflow.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workflow_params
      params.fetch(:workflow, {}).permit(:name, :description)
    end
end
