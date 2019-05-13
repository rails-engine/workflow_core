# frozen_string_literal: true

module Bpmn
  class DefinitionContainer
    attr_reader :collection

    def initialize(tokens)
      @collection = tokens.map { |t| { t.id => t } }.reduce(&:merge!)
      @start_id = tokens.first { |t| t.node_type == :start_event }.id
    end

    def start_event
      @collection[@start_id]
    end

    def [](id)
      @collection[id]
    end

    def slice(*ids)
      @collection.slice(*ids).values
    end

    def self.parse(bpmn_xml)
      tokens = Bpmn::Tokenizer.new.tokenize(bpmn_xml)
      return nil unless tokens

      new tokens
    end
  end
end
