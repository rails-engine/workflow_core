# frozen_string_literal: true

module Transitions::Options
  module Votable
    extend ActiveSupport::Concern

    included do
      attribute :vote_rule, type: :string, default: "one_vote_pass"

      enum vote_rule: {
        one_vote_pass: "one_vote_pass"
      }
    end
  end
end
