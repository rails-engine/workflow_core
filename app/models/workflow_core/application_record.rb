# frozen_string_literal: true

module WorkflowCore
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
