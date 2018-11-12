class FalseClass
  def dup
    self
  end
end

class TrueClass
  def dup
    self
  end
end

class Method
  def dup
    self
  end
end

class NilClass
  def dup
    self
  end
end

class Numeric
  def dup
    self
  end
end

class Decimal
  def dup
    self
  end
end

class Symbol
  def dup
    self
  end
end

class Object
  def deep_dup
    dup
  end
end

class Hash
  def deep_dup
    # Different with Shopify's
    each_with_object(dup) do |(key, value), hash|
      hash[key.deep_dup] = value.deep_dup
    end
  end
end

class Array
  def deep_dup
    map { |it| it.deep_dup }
  end
end