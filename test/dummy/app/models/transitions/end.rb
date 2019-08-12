# frozen_string_literal: true

class Transitions::End < Transition
  def on_fire(token, _transaction_options, **_options)
    token.completed!
    token.instance.completed!
  end

  def auto_forwardable?
    true
  end

  def options_configurable?
    false
  end
end
