# frozen_string_literal: true

module Bpmn
  class Tokens::UserTask < Bpmn::Tokens::CommonToken
    def task?
      true
    end
  end
end
