# frozen_string_literal: true

module Bpmn
  class Tokens::ScriptTask < Bpmn::Tokens::CommonToken
    attr_reader :script_format, :script

    def initialize(element)
      super

      @script_format = element["scriptFormat"]
      @script = element.at_xpath("bpmn:script").try(:content)
    end

    def task?
      true
    end

    def to_hash
      super.merge(
        extensions: {
          script_format: script_format,
          script: script
        }
      )
    end
  end
end
