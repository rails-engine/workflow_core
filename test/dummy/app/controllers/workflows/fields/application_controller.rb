# frozen_string_literal: true

module Workflows
  class Fields::ApplicationController < ApplicationController
    before_action :set_field

    protected

      # Use callbacks to share common setup or constraints between actions.
      def set_field
        @field = @workflow.fields.find(params[:field_id])
      end
  end
end
