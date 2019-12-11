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

  def renter_with_highest_rent
    occupied_units = @units.find_all { |unit| unit.renter }
    highest_rent_renter = nil
    highest_rent = 0
    occupied_units.each do |unit|
      if unit.monthly_rent > highest_rent
        highest_rent_renter = unit.renter
        highest_rent = unit.monthly_rent
      end
    end
    highest_rent_renter
  end

end
