# frozen_string_literal: true

module Transitions::Options
  class Decision < FieldOptions
    include FieldOverridable
    include Votable

    embeds_many :actions, class_name: "Transitions::Options::Decision::Action"
    accepts_nested_attributes_for :actions, allow_destroy: true

    class Action < FieldOptions
      attribute :text, :string
      attribute :value, :string
      attribute :place_id, :integer

      validates :text, :value, :place_id,
                presence: true
    end
  end
end
