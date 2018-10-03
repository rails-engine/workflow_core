# frozen_string_literal: true

module WorkflowCore::Concerns
  module Models
    module Transition
      extend ActiveSupport::Concern

      def fire(token, transaction_options: {requires_new: true}, **options)
        transaction(**transaction_options) do
          on_fire(token, transaction_options, options)
        end
      rescue => ex
        rescue_fire_error ex
      end

      protected

      def on_fire(_token, _transaction_options, **_options)
        raise NotImplementedError
      end

      def rescue_fire_error(ex)
        raise ex
      end
    end
  end
end
