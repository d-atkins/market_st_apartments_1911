class Building
  attr_reader :units

  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def average_rent
    rents = @units.map { |unit| unit.monthly_rent }
    rents.sum.to_f / rents.length
  end

end
