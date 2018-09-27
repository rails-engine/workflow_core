# frozen_string_literal: true

module Bpmn
  class Tokens::SequenceFlow < Bpmn::Tokens::Token
    attr_reader :source_id, :target_id
    attr_reader :condition_expression

    def initialize(element)
      super

      @source_id = element["sourceRef"]
      @target_id = element["targetRef"]

      @condition_expression = Bpmn::Tokens::Extensions::ConditionExpression.factory(element)
    end

    def flow?
      true
    end

    def to_hash
      super.merge(
        source_id: source_id,
        target_id: target_id,
        extensions: {
          condition_expression: condition_expression.to_hash
        }
      )
    end
  end
end
