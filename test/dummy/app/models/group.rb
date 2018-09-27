# frozen_string_literal: true

class Group < ApplicationRecord
  has_closure_tree dependent: :nullify

  has_many :users, dependent: :nullify

  validates :name,
            presence: true
end
