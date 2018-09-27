# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :group

  validates :name,
            presence: true
end
