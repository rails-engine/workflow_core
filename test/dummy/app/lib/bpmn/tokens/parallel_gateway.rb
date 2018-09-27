# frozen_string_literal: true

module Bpmn
  class Tokens::ParallelGateway < Bpmn::Tokens::CommonToken
    def gateway?
      true
    end
  end
end
