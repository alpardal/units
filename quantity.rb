class Quantity
  attr_reader :amount, :unit

  def initialize(amount, unit)
    @amount = amount
    @unit = unit
  end

  def add(other, conversions)
    if same_unit?(other)
      self.class.new(other.amount + amount, unit)
    else
      add(other.to(unit, conversions), conversions)
    end
  end

  def to(new_unit, conversions)
    new_amount = conversions.convert(unit, new_unit, amount)
    self.class.new(new_amount, new_unit)
  end

  def same_unit?(other)
    unit == other.unit
  end

  def to_s
    "%.4g %s" % [amount, unit]
  end
end
