# frozen_string_literal: true

module Bpmn
  class Tokens::Token
    attr_reader :id, :name, :node_type
    attr_reader :documentation

    def initialize(element)
      # @element = element
      @id = element["id"]
      @name = element["name"] || ""
      @node_type = element.name.underscore.to_sym

      @documentation = element.at_xpath("bpmn:documentation")&.content || ""
    end

    def gateway?
      false
    end

    def event?
      false
    end

    def task?
      false
    end

    def flow?
      false
    end

    def to_hash
      {
        node_id: id,
        node_type: node_type,
        name: name
      }
    end
    alias_method :to_h, :to_hash
  end
end
