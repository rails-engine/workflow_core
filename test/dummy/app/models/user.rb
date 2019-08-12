# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :group, optional: true

  validates :name,
            presence: true
end
