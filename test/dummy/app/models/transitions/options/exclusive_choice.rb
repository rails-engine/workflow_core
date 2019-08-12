# frozen_string_literal: true

module Transitions::Options
  class ExclusiveChoice < FieldOptions
    attribute :default_next_place_id, :integer

    embeds_many :conditions, class_name: "Transitions::Options::ExclusiveChoice::Condition"
    accepts_nested_attributes_for :conditions

    validates :default_next_place_id,
              presence: true

    class Condition < FieldOptions
      attribute :condition_expression, :string
      attribute :place_id, :integer

      validates :condition_expression, :place_id,
                presence: true
    end
  end
end
