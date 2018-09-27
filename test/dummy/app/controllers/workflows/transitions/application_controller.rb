# frozen_string_literal: true

module Workflows
  class Transitions::ApplicationController < ApplicationController
    before_action :set_transition

    protected

    # Use callbacks to share common setup or constraints between actions.
    def set_transition
      @transition = @workflow.transitions.find(params[:transition_id])
    end
  end
end
