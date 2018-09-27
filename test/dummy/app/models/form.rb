# frozen_string_literal: true

class Form < ApplicationRecord
  include FormCore::Concerns::Models::Form

  self.table_name = "forms"

  belongs_to :workflow

  has_many :fields, foreign_key: "form_id", dependent: :destroy
end
