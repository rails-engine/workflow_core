# frozen_string_literal: true

module Bpmn
  class Tokenizer
    def tokenize(bpmn_xml)
      return nil if bpmn_xml.blank?

      doc = begin
              Nokogiri::XML(bpmn_xml)
            rescue StandardError
              nil
            end
      return nil unless doc && doc.errors.count.zero?

      process = begin
                  doc.at_xpath("//bpmn:process")
                rescue StandardError
                  nil
                end
      return nil unless process

      return if process.blank?

      process.elements.map { |el| factory(el) }.compact
    end

    private

      def factory(element)
        case element.name
        when "startEvent"
          Bpmn::Tokens::StartEvent.new(element)
        when "endEvent"
          Bpmn::Tokens::EndEvent.new(element)
        when "task"
          Bpmn::Tokens::Task.new(element)
        when "userTask"
          Bpmn::Tokens::UserTask.new(element)
        when "scriptTask"
          Bpmn::Tokens::ScriptTask.new(element)
        when "parallelGateway"
          Bpmn::Tokens::ParallelGateway.new(element)
        when "exclusiveGateway"
          Bpmn::Tokens::ExclusiveGateway.new(element)
        when "inclusiveGateway"
          Bpmn::Tokens::InclusiveGateway.new(element)
        when "sequenceFlow"
          Bpmn::Tokens::SequenceFlow.new(element)
        else
          raise NotImplementedError, "#{element.name} is unsupported yet."
        end
      end
  end
end
