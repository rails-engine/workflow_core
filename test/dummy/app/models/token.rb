# frozen_string_literal: true

class Token < WorkflowCore::Token
  belongs_to :assignable, polymorphic: true, optional: true
  belongs_to :forwardable, polymorphic: true, optional: true

  serialize :payload, Payload

  class Payload < FieldOptions
    attribute :note, type: :string
    attribute :action, type: :string
  end
end
