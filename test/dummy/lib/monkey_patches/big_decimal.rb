# frozen_string_literal: true

class BigDecimal
  # TODO: TEMP FIX BECAUSE SCRIPT_CORE NOT DONE YET.
  def to_msgpack(*args)
    to_f.to_msgpack(*args)
  end
end
