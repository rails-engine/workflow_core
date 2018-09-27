# frozen_string_literal: true

module Bpmn
  class Tokens::EndEvent < Bpmn::Tokens::CommonToken
    def event?
      true
    end
  end
end
