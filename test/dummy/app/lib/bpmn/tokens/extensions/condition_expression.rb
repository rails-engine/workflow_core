# frozen_string_literal: true

module Bpmn
  class Tokens::Extensions::ConditionExpression
    attr_reader :language, :condition, :type

    def initialize(element)
      @language = element["language"]
      @condition = element.content
      @type = element["xsi:type"]
    end

    def self.factory(xelement)
      ce = xelement.at_xpath("bpmn:conditionExpression")
      return nil unless ce

      new(ce)
    end

    def to_hash
      {
        language: language,
        condition: condition,
        type: type
      }
    end
    alias to_h to_hash
  end
end
