# frozen_string_literal: true

module Bpmn
  class Tokenizer
    def tokenize(bpmn_xml)
      return nil unless bpmn_xml.present?

      doc = Nokogiri::XML(bpmn_xml) rescue nil
      return nil unless doc && doc.errors.count.zero?

      process = doc.at_xpath("//bpmn:process") rescue nil
      return nil unless process

      return unless process.present?
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
        raise NotImplementedError.new("#{element.name} is unsupported yet.")
      end
    end
  end
end
