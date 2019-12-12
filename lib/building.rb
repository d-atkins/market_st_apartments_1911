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

  def get_occupied_units
    @units.find_all { |unit| unit.renter }
  end

  def renter_with_highest_rent
    occupied_units = get_occupied_units
    occupied_units.max_by {|unit| unit.monthly_rent}.renter unless occupied_units.empty?
  end

  def annual_breakdown
    get_occupied_units.reduce({}) do |acc, unit|
      acc[unit.renter.name] = unit.monthly_rent * 12
      acc
    end
  end
end
