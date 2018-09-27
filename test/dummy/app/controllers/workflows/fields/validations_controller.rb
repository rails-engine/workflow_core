# frozen_string_literal: true

module Workflows
  class Fields::ValidationsController < Fields::ApplicationController
    before_action :set_validations

    def edit
    end

    def update
      @validations.assign_attributes(validations_params)
      if @validations.valid? && @field.save(validate: false)
        redirect_to workflow_fields_url(@workflow), notice: "Field was successfully updated."
      else
        render :edit
      end
    end

    private

    def set_validations
      @validations = @field.validations
    end

    def validations_params
      params.fetch(:validations, {}).permit!
    end
  end
end
