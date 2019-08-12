# frozen_string_literal: true

class Workflows::InstancesController < Workflows::ApplicationController
  before_action :require_signed_in
  before_action :set_instance, only: %i[show]

  # GET /workflows/1/instances
  def index
    @instances = @workflow.instances.all
  end

  # GET /workflows/1/instances
  def show
    @form = @workflow.form
    @virtual_model = @form.to_virtual_model
    @form_record = @virtual_model.new(@instance.payload)

    render layout: "workflow_instances"
  end

  def new
    @form = @workflow.form
    overrides = @workflow.start_place.output_transition.options.field_overrides.map { |o| { o.name => { accessibility: o.accessibility } } }.reduce(&:merge) || {}
    @virtual_model = @form.to_virtual_model overrides: overrides

    @form_record = @virtual_model.new
  end

  # POST /workflows/1/instances
  def create
    @form = @workflow.form
    overrides = @workflow.start_place.output_transition.options.field_overrides.map { |o| { o.name => { accessibility: o.accessibility } } }.reduce(&:merge) || {}
    @virtual_model = @form.to_virtual_model overrides: overrides

    @form_record = @virtual_model.new form_record_params
    render :new unless @form_record.valid?

    @instance = @workflow.instances.create! type: "WorkflowInstance", creator: current_user
    @instance.update! payload: @form_record.serializable_hash
    start_token = @instance.tokens.first
    start_token.place.output_transition.fire(start_token)

    redirect_to workflow_instance_tokens_url(@workflow, @instance), notice: "instance was successfully created."
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_instance
      @instance = @workflow.instances.find(params[:id])
    end

    def form_record_params
      params.fetch(:form_record, {}).permit!
    end
end
