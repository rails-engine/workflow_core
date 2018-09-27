# frozen_string_literal: true

module Bpmn
  class Tokens::Task < Bpmn::Tokens::CommonToken
    def task?
      true
    end
  end
end
