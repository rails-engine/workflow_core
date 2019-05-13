# frozen_string_literal: true

module Workflows
  class Instances::ApplicationController < ApplicationController
    layout "workflow_instances"

    before_action :set_instance

    protected

      # Use callbacks to share common setup or constraints between actions.
      def set_instance
        @instance = @workflow.instances.find(params[:instance_id])
      end
  end
end
