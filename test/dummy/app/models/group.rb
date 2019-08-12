# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :name,
            presence: true
end
