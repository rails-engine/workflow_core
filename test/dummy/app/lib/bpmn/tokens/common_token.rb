# frozen_string_literal: true

module Bpmn
  class Tokens::CommonToken < Bpmn::Tokens::Token
    attr_reader :incoming_ids, :outgoing_ids

    def initialize(element)
      super

      @incoming_ids = element.xpath("bpmn:incoming").map(&:content)
      @outgoing_ids = element.xpath("bpmn:outgoing").map(&:content)
    end

    def to_hash
      super.merge(
        incoming_ids: incoming_ids,
        outgoing_ids: outgoing_ids
      )
    end
  end
end
