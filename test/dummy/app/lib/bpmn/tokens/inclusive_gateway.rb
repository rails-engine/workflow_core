# frozen_string_literal: true

module Bpmn
  class Tokens::InclusiveGateway < Bpmn::Tokens::CommonToken
    attr_reader :default_flow_id

    def initialize(element)
      super

      @default_flow_id = element["default"]
    end

    def gateway?
      true
    end

    def to_hash
      super.merge(
        default_flow_id: default_flow_id
      )
    end
  end
end
