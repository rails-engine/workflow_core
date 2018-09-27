# frozen_string_literal: true

module Workflows
  class Instances::TokensController < Instances::ApplicationController
    before_action :set_token, only: %i[show fire]
    before_action :set_form_model, only: %i[show fire]

    # GET /workflows/1/tokens
    def index
      @tokens = @instance.tokens.includes(place: :output_transition)
    end

    # POST /workflows/1/tokens/1/fire
    def show
      @form_record = @virtual_model.load(@instance.payload)
    end

    # POST /workflows/1/tokens/1/fire
    def fire
      @form_record = @virtual_model.load(@instance.payload)
      @form_record.assign_attributes(form_record_params)

      if @form_record.valid?
        @instance.update! payload: (@instance.payload || {}).merge(@form_record.serializable_hash)
        @token.place.output_transition.fire(@token)

        redirect_to workflow_instance_tokens_url(@workflow, @instance), notice: "Token was successfully fired."
      else
        render :show
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = @instance.tokens.find(params[:id] || params[:token_id])
    end

    def set_form_model
      @form = @workflow.form
      overrides = @token.place.output_transition.options.field_overrides.map { |o| {o.name => {accessibility: o.accessibility}} }.reduce(&:merge) || {}
      @virtual_model = @form.to_virtual_model overrides: overrides
    end

    def form_record_params
      params.fetch(:form_record, {}).permit!
    end
  end
end
