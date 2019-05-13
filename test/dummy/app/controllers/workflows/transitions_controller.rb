# frozen_string_literal: true

class Workflows::TransitionsController < Workflows::ApplicationController
  before_action :set_transition, only: %i[edit update destroy]

  # GET /workflows/1/transitions
  def index
    @transitions = @workflow.transitions.all
  end

  # GET /workflows/transitions/new
  def new
    @transition = @workflow.transitions.build
  end

  # GET /workflows/1/transitions/1/edit
  def edit; end

  # POST /workflows/1/transitions
  def create
    @transition = @workflow.transitions.build(transition_params)

    if @transition.save
      redirect_to workflow_transitions_url(@workflow), notice: "transition was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /workflows/1/transitions/1
  def update
    if @transition.update(transition_params)
      redirect_to workflow_transitions_url(@workflow), notice: "transition was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /workflows/1/transitions/1
  def destroy
    @transition.destroy
    redirect_to workflow_transitions_url(@workflow), notice: "transition was successfully destroyed."
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_transition
      @transition = @workflow.transitions.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transition_params
      params.fetch(:transition, {}).permit(:name, :type)
    end
end
