# frozen_string_literal: true

class Token
  class Payload < FieldOptions
    attribute :note, type: :string
    attribute :action, type: :string
  end
end
