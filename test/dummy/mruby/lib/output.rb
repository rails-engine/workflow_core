module Output
  class << self
    SUPPORTED_CLASSES = [Symbol, FalseClass, TrueClass, Float, Integer, String]

    attr_accessor :value

    def dump
      return nil if value.nil?
      unless value_type_supported?(value)
        raise "Output can't pass to host Ruby."
      end

      value
    end

    private

    def value_type_supported?(value)
      return true if value.nil?

      if value.is_a? Hash
        return false if value.keys.map { |i| value_type_supported?(i) }.any? { |i| !i }
        return false if value.values.map { |i| value_type_supported?(i) }.any? { |i| !i }
      elsif value.is_a? Array
        return false if value.map { |i| value_type_supported?(i) }.any? { |i| !i }
      end

      for klass in SUPPORTED_CLASSES
        return true if value.is_a? klass
      end

      false
    end
  end
end
