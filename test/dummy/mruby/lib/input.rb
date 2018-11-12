module Input
  class << self
    def load(input)
      @input = input || {}
      @input.freeze
    end

    def [](key)
      @input[key]
    end

    def to_s
      @input.to_s
    end

    def value
      @input
    end
  end
end
