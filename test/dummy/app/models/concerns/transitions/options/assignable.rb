# frozen_string_literal: true

module Transitions::Options
  module Assignable
    extend ActiveSupport::Concern

    included do
      attribute :assignee_user_ids, type: :string, array: true
      attribute :assign_to, type: :string, default: "creator"

      enum assign_to: {
        creator: "creator",
        specific: "specific",
        inherited: "inherited"
      }, _prefix: :assign_to

      validates :assign_to,
                presence: true
    end
  end
end
