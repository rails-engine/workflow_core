# frozen_string_literal: true

class Workflows::FieldsController < Workflows::ApplicationController
  before_action :set_form
  before_action :set_field, only: %i[show edit update destroy]

  # GET /workflows/1/fields
  def index
    @fields = @form.fields.all
  end

  # GET /workflows/fields/new
  def new
    @field = @form.fields.build
  end

  # GET /workflows/1/fields/1/edit
  def edit
  end

  # POST /workflows/1/fields
  def create
    @field = @form.fields.build(field_params)

    if @field.save
      redirect_to workflow_fields_url(@workflow), notice: "Field was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /workflows/1/fields/1
  def update
    if @field.update(field_params)
      redirect_to workflow_fields_url(@workflow), notice: "Field was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /workflows/1/fields/1
  def destroy
    @field.destroy
    redirect_to workflow_fields_url(@workflow), notice: "Field was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = @workflow.form
  end

  def set_field
    @field = @form.fields.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def field_params
    params.fetch(:field, {}).permit(:name, :label, :hint, :type)
  end
end
