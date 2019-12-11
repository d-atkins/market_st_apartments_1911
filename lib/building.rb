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
    occupied_units = @units.find_all { |unit| unit.renter }
    occupied_units
  end

  def renter_with_highest_rent
    occupied_units = get_occupied_units
    max_rent = occupied_units.map { |unit| unit.monthly_rent }.max
    max_rent_unit = occupied_units.find { |unit| unit.monthly_rent == max_rent }
    max_rent_unit.renter if max_rent_unit
  end

  def annual_breakdown
    occupied_units = get_occupied_units
    breakdown = Hash.new
    occupied_units.each do |unit|
      breakdown[unit.renter.name] = unit.monthly_rent * 12
    end
    breakdown
  end
end
